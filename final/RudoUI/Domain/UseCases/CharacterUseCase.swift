//
//  RMCharacterUseCase.swift
//  RudoUI
//
//  Created by Fernando Salom Carratala on 15/6/23.
//

import Foundation

protocol CharacterUseCaseProtocol {
    func getCharactersAndNextPage(for page: Int) async throws -> ([RMCharacter], Bool)
    func getCharactersAndNextPageWhenSearching(this name: String, for page: Int) async throws -> ([RMCharacter], Bool)
}

final class CharacterUseCase {
    let repository: CharacterRepositoryProtocol

    init(repository: CharacterRepositoryProtocol) {
        self.repository = repository
    }
}

extension CharacterUseCase: CharacterUseCaseProtocol {
    func getCharactersAndNextPage(for page: Int) async throws -> ([RMCharacter], Bool) {
        let pagination = try await repository.getPagination(for: page)
        return (pagination.characters, pagination.hasNextPage)
    }

    func getCharactersAndNextPageWhenSearching(this name: String,
                                               for page: Int) async throws -> ([RMCharacter], Bool) {
        let pagination = try await repository.getPaginationWhenSearching(this: name, for: page)
        return (pagination.characters, pagination.hasNextPage)
    }
}
