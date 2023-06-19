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
}

final class CharacterRepository: CharacterRepositoryProtocol {
    var networkDatasource: RMCharacterDataSourceProtocol
    var localDatasource: RMCharacterDataSourceProtocol

    init(networkDatasource: RMCharacterDataSourceProtocol,
         localDatasource: RMCharacterDataSourceProtocol) {
        self.networkDatasource = networkDatasource
        self.localDatasource = localDatasource
    }

    func getPagination(for page: Int) async throws -> Pagination {
        guard let localPagination = try await localDatasource.getPagination(for: page) else {
            let networkPagination = try await networkDatasource.getPagination(for: page)
            return networkPagination!
        }
        return localPagination
    }

    func getPaginationWhenSearching(this name: String, for page: Int) async throws -> Pagination {
        guard let localPagination = try await localDatasource.getPaginationWhenSearching(this: name, for: page) else {
            let networkPagination = try await networkDatasource.getPaginationWhenSearching(this: name, for: page)
            return networkPagination!
        }
        return localPagination
    }
}
