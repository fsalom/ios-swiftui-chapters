//
//  RMLocalDataSource.swift
//  RudoUI
//
//  Created by Fernando Salom Carratala on 28/6/23.
//

import Foundation

class RMCacheDataSource: RMCharacterDataSourceProtocol {
    var localManager: LocalManagerProtocol

    init(localManager: LocalManagerProtocol) {
        self.localManager = localManager
    }

    func getPagination(for page: Int) async throws -> Pagination? {
        return nil
    }

    func getPaginationWhenSearching(this name: String, for page: Int) async throws -> Pagination? {
        return nil
    }

    func getFavorites() async throws -> [Character] {
        guard let favoritesDTO = localManager.retrieve(objectFor: "favorites", of: [RMCharacterDTO].self ) else { return []}
        return favoritesDTO.map({ Character(dto: $0)})
    }

    func saveFavorite(_ character: Character) async throws {
        let favorites = try await self.getFavorites()
        var favoritesDTO = favorites.map({ RMCharacterDTO(entity: $0)})
        let characterDTO = RMCharacterDTO(entity: character)
        favoritesDTO.removeAll(where: {$0.id == character.id})
        favoritesDTO.append(characterDTO)

        localManager.save(objectFor: "favorites", this: favoritesDTO)
    }

    func removeFavorite(_ character: Character) async throws {
        let favorites = try await self.getFavorites()
        var favoritesDTO = favorites.map({ RMCharacterDTO(entity: $0)})
        favoritesDTO.removeAll(where: {$0.id == character.id})

        localManager.save(objectFor: "favorites", this: favoritesDTO)
    }
}
