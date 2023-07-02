//
//  DetailCharacterViewModel.swift
//  RudoUI
//
//  Created by Fernando Salom Carratala on 16/6/23.
//

import Foundation

class DetailCharacterViewModel: ObservableObject, DetailCharacterViewModelProtocol {
    @Published var character: RMCharacter

    var useCase: CharacterUseCaseProtocol!

    init(useCase: CharacterUseCaseProtocol, character: RMCharacter) {
        self.useCase = useCase
        self.character = character
    }

}
