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

    var useCase: CharacterUseCaseProtocol!

    init(useCase: CharacterUseCaseProtocol) {
        // MARK: general properties
        self.useCase = useCase
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
        let (characters, hasNextPage) = try await useCase.getCharactersAndNextPage(for: 1)
        await MainActor.run {
            self.characters.append(contentsOf: characters)
        }
    }
}
