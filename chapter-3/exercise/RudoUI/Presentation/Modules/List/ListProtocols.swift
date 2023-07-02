//
//  ListProtocols.swift
//  RudoUI
//
//  Created by Fernando Salom Carratala on 15/6/23.
//

import Foundation

protocol ListViewModelProtocol: ObservableObject  {
    var characters: [RMCharacter] { get set }
    var hasNextPage: Bool { get set }
    func load() async
}


