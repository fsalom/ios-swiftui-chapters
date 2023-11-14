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
        guard let charactersDTO = localManager.retrieve(objectFor: "FAVORITES", of: [RMCharacterDTO].self) else {
            return []
        }
        var characters = [RMCharacter]()
        for characterDTO in charactersDTO {
            characters.append(RMCharacter(dto: characterDTO))
        }
        return characters
    }

    func saveFavorite(_ character: RMCharacter) async throws {
        var charactersDTO = localManager.retrieve(objectFor: "FAVORITES", of: [RMCharacterDTO].self) ?? []
        let characterDTO = RMCharacterDTO(entity: character)
        charactersDTO.append(characterDTO)
        localManager.save(objectFor: "FAVORITES", this: charactersDTO)
    }

    func removeFavorite(_ character: RMCharacter) async throws {
        guard var charactersDTO = localManager.retrieve(objectFor: "FAVORITES", of: [RMCharacterDTO].self) else {
            return
        }
        charactersDTO.removeAll(where: { $0.id == character.id })
        localManager.save(objectFor: "FAVORITES", this: charactersDTO)
    }
}
