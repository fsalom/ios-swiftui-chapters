//
//  ListViewModel.swift
//  RudoUI
//
//  Created by Fernando Salom Carratala on 15/6/23.
//

import Foundation

class ListViewModel: ObservableObject, ListViewModelProtocol {
    @Published var characters: [RMCharacter] = []
    @Published var hasOcurredAnError: Bool = false
    @Published var hasMoreCharactersPendingToLoad: Bool = true
    @Published var searchText: String {
        didSet {
            if !searchText.isEmpty && searchText.count > 2 {
                saveCurrentCharactersToInitiateSearch()
                search(this: searchText)
            }
            if searchText.isEmpty {
                resetListWithPreviousCharacters()
            }
        }
    }

    var originalCharacters: [RMCharacter] = []
    var originalPage: Int = 1

    var searchHasNextPage: Bool {
        didSet {
            hasMoreCharactersPendingToLoad = searchHasNextPage
            page += searchHasNextPage ? 1 : 0
        }
    }

    var page: Int = 1
    var hasNextPage: Bool {
        didSet {
            hasMoreCharactersPendingToLoad = hasNextPage
            page += hasNextPage ? 1 : 0
        }
    }
    var useCase: CharacterUseCaseProtocol!

    init(useCase: CharacterUseCaseProtocol) {
        // MARK: general properties
        self.useCase = useCase
        self.hasNextPage = true

        // MARK: search properties
        self.searchText = ""
        self.searchHasNextPage = true
        self.originalPage = 1
    }

    func loadMoreIfNeeded() {
        Task {
            do {
                if searchText.isEmpty {
                    try await fetchCharacters()
                } else {
                    search(this: searchText)
                }
            } catch {
                hasOcurredAnError = true
            }
        }
    }

    func load() async {
        do {
            if characters.isEmpty {
                try await fetchCharacters()
            }
        } catch {
            hasOcurredAnError = true
        }
    }

    func fetchCharacters() async throws {
        if hasNextPage {
            let (characters, hasNextPage) = try await useCase.getCharactersAndNextPage(for: page)
            await MainActor.run {
                self.characters.append(contentsOf: characters)
                self.hasNextPage = hasNextPage
            }
        }
    }

    func addOrRemove(this character: RMCharacter) {
        Task {
            if character.isFavorite {
                try await self.useCase.saveFavorite(character)
            } else {
                try await self.useCase.removeFavorite(character)
            }
        }
    }

    func search(this text: String) {
        Task {
            if searchHasNextPage {
                do {
                    let (characters, hasNextPage) = try await useCase.getCharactersAndNextPageWhenSearching(this: text, for: page)
                    await MainActor.run {
                        self.characters.append(contentsOf: characters)
                        self.searchHasNextPage = hasNextPage
                    }
                } catch {
                    await MainActor.run {
                        hasOcurredAnError = true
                    }
                }
            }
        }
    }

    func resetListWithPreviousCharacters() {
        if !originalCharacters.isEmpty {
            self.hasMoreCharactersPendingToLoad = self.hasNextPage
            self.characters = self.originalCharacters
            self.page = self.originalPage
            self.originalCharacters.removeAll()
            self.originalPage = 1
        }
    }

    func saveCurrentCharactersToInitiateSearch() {
        page = 1
        if originalCharacters.isEmpty {
            originalCharacters = characters
            originalPage = page

            characters.removeAll()
            page = 1
            searchHasNextPage = true
        }
    }
}
