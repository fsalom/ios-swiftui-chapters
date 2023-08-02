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
        return []
    }

    func saveFavorite(_ character: RMCharacter) async throws {

    }

    func removeFavorite(_ character: RMCharacter) async throws {

    }
}
