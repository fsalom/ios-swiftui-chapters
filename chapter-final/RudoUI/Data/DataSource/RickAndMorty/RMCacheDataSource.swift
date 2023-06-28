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

    func getFavorites() async throws -> [RMCharacter] {
        guard let favoritesDTO = localManager.retrieve(objectFor: "favorites", of: [RMCharacterDTO].self ) else { return []}
        print(favoritesDTO)
        return favoritesDTO.map({ RMCharacter(dto: $0)})
    }

    func saveFavorite(_ character: RMCharacter) async throws {
        let favorites = try await self.getFavorites()
        var favoritesDTO = favorites.map({ RMCharacterDTO(entity: $0)})
        let characterDTO = RMCharacterDTO(entity: character)
        favoritesDTO.removeAll(where: {$0.name == character.name})
        favoritesDTO.append(characterDTO)

        localManager.save(objectFor: "favorites", this: favoritesDTO)
    }

    func removeFavorite(_ character: RMCharacter) async throws {
        let favorites = try await self.getFavorites()
        var favoritesDTO = favorites.map({ RMCharacterDTO(entity: $0)})
        favoritesDTO.removeAll(where: {$0.name == character.name})

        localManager.save(objectFor: "favorites", this: favoritesDTO)
    }
}
