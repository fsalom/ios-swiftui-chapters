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
    var page: Int = 1
    var hasNextPage: Bool {
        didSet {
            if hasNextPage {
                page += 1
            }
        }
    }
    var useCase: CharacterUseCaseProtocol!

    init(useCase: CharacterUseCaseProtocol) {
        self.useCase = useCase
        self.hasNextPage = true
    }

    func load() async {
        do {
            try await fetchCharacters()
        } catch {
            hasOcurredAnError = true
        }
    }

    func fetchCharacters() async throws {
        let (characters, hasNextPage) = try await useCase.getCharactersAndNextPage(for: page)
        await MainActor.run {
            self.characters.append(contentsOf: characters)
            self.hasNextPage = hasNextPage
        }
    }
}
