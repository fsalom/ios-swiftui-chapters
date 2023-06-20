//
//  DetailCharacterViewModel.swift
//  RudoUI
//
//  Created by Fernando Salom Carratala on 16/6/23.
//

import Foundation

class DetailCharacterViewModel: ObservableObject, DetailCharacterViewModelProtocol {
    @Published var character: RMCharacter
    @Published var errorOccurred: Bool = false
    @Published var relatedCharacters: [RMCharacter] = []

    var useCase: CharacterUseCaseProtocol!

    init(useCase: CharacterUseCaseProtocol, character: RMCharacter) {
        self.useCase = useCase
        self.character = character
        self.relatedCharacters = relatedCharacters
    }

    func getRelatedCharacters() async {
        do {
            let first_name = character.name.split(separator: " ").first ?? ""
            let (relatedCharacters, _) = try await useCase.getCharactersAndNextPageWhenSearching(this: String(first_name), for: 1)
            await MainActor.run {
                self.relatedCharacters = relatedCharacters.filter { $0.name != character.name }
            }
        } catch {
            errorOccurred = true
        }
    }
}
