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
    func setFavorites(to characters: [RMCharacter]) async throws -> [RMCharacter]
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
        let charactersWithFavorite = try await setFavorites(to: pagination.characters)
        return (charactersWithFavorite, pagination.hasNextPage)
    }

    func getCharactersAndNextPageWhenSearching(this name: String,
                                               for page: Int) async throws -> ([RMCharacter], Bool) {
        let pagination = try await repository.getPaginationWhenSearching(this: name, for: page)
        let charactersWithFavorite = try await setFavorites(to: pagination.characters)
        return (charactersWithFavorite, pagination.hasNextPage)
    }

    func getCharactersRelatedTo(this character: RMCharacter) async throws -> [RMCharacter] {
        let name = character.name.split(separator: " ")
        guard let first_name = name.first else { return [] }
        let pagination = try await repository.getPaginationWhenSearching(this: String(first_name), for: 1)
        return pagination.characters.filter({$0.name != character.name})
    }

    func getFavorites() async throws -> [RMCharacter] {
        return try await repository.getFavorites()
    }

    func saveFavorite(_ character: RMCharacter) async throws {
        try await repository.saveFavorite(character)
    }

    func removeFavorite(_ character: RMCharacter) async throws {
        try await repository.removeFavorite(character)
    }

    func setFavorites(to characters: [RMCharacter]) async throws -> [RMCharacter] {
        var charactersWithFavorite = characters
        let favorites = try await getFavorites()

        for (index, character) in charactersWithFavorite.enumerated()
        {
            charactersWithFavorite[index].isFavorite = false
        }

        for favorite in favorites {
            guard let index = charactersWithFavorite.lastIndex(where: {$0.id == favorite.id}) else {
                continue
            }
            charactersWithFavorite[index].isFavorite = true
        }

        return charactersWithFavorite
    }
}
