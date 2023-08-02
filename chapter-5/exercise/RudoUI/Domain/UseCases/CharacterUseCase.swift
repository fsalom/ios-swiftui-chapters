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
    func getCharactersRelatedTo(this character: RMCharacter) async throws -> [RMCharacter]
    func getFavorites() async throws -> [RMCharacter]
    func saveFavorite(_ character: RMCharacter) async throws
    func removeFavorite(_ character: RMCharacter) async throws
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

    func getCharactersRelatedTo(this character: RMCharacter) async throws -> [RMCharacter] {
        let name = character.name.split(separator: " ")
        guard let first_name = name.first else { return [] }
        let pagination = try await repository.getPaginationWhenSearching(this: String(first_name), for: 1)
        return pagination.characters.filter({$0.name != character.name})
    }

    func getFavorites() async throws -> [RMCharacter] {
        return []
    }

    func saveFavorite(_ character: RMCharacter) async throws {

    }

    func removeFavorite(_ character: RMCharacter) async throws {

    }

    func setFavorites(to characters: [RMCharacter]) async throws -> [RMCharacter] {
        return []
    }
}
