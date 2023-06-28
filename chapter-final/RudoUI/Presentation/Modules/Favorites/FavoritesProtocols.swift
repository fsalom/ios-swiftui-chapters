//
//  FavoritesProtocols.swift
//  RudoUI
//
//  Created by Fernando Salom Carratala on 28/6/23.
//

import Foundation

protocol FavoritesViewModelProtocol: ObservableObject  {
    var characters: [RMCharacter] { get set }
    var errorOccurred: Bool { get set }
    func load() async
}
