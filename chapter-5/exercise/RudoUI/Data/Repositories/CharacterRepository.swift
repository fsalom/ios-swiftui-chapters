//
//  RickAndMortyRepository.swift
//  RudoUI
//
//  Created by Fernando Salom Carratala on 15/6/23.
//

import Foundation

protocol CharacterRepositoryProtocol {
    func getPagination(for page: Int) async throws -> Pagination
    func getPaginationWhenSearching(this name: String, for page: Int) async throws -> Pagination
    func getFavorites() async throws -> [RMCharacter]
    func saveFavorite(_ character: RMCharacter) async throws
    func removeFavorite(_ character: RMCharacter) async throws
}

final class CharacterRepository: CharacterRepositoryProtocol {
    var networkDatasource: RMCharacterDataSourceProtocol
    var cacheDatasource: RMCharacterDataSourceProtocol

    init(networkDatasource: RMCharacterDataSourceProtocol,
         cacheDatasource: RMCharacterDataSourceProtocol) {
        self.networkDatasource = networkDatasource
        self.cacheDatasource = cacheDatasource
    }

    func getPagination(for page: Int) async throws -> Pagination {        
        guard let cachePagination = try await cacheDatasource.getPagination(for: page) else {
            let networkPagination = try await networkDatasource.getPagination(for: page)
            return networkPagination!
        }
        return cachePagination
    }

    func getPaginationWhenSearching(this name: String, for page: Int) async throws -> Pagination {
        guard let cachePagination = try await cacheDatasource.getPaginationWhenSearching(this: name, for: page) else {
            let networkPagination = try await networkDatasource.getPaginationWhenSearching(this: name, for: page)
            return networkPagination!
        }
        return cachePagination
    }

    func getFavorites() async throws -> [RMCharacter] {
        return try await cacheDatasource.getFavorites()
    }

    func saveFavorite(_ character: RMCharacter) async throws {
        try await cacheDatasource.saveFavorite(character)
    }

    func removeFavorite(_ character: RMCharacter) async throws {
        try await cacheDatasource.removeFavorite(character)
    }
}
