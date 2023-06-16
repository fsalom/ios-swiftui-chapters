//
//  ListViewModel.swift
//  RudoUI
//
//  Created by Fernando Salom Carratala on 15/6/23.
//

import Foundation

class ListViewModel: ObservableObject, ListViewModelProtocol {
    @Published var characters: [RMCharacter] = []
    var page: Int = 0
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

    func load() {
        Task {
            (characters, hasNextPage) = try await useCase.getCharactersAndNextPage(for: page)
        }
    }
}
