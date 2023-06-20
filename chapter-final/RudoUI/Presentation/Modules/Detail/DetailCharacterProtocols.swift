//
//  DetailCharacterProtocols.swift
//  RudoUI
//
//  Created by Fernando Salom Carratala on 16/6/23.
//

import Foundation

protocol DetailCharacterViewModelProtocol: ObservableObject  {
    var character: RMCharacter { get set }
    var errorOccurred: Bool { get set }
    var relatedCharacters: [RMCharacter] { get set }
    func getRelatedCharacters() async
}
