//
//  RickAndMortyRemoteDataSource.swift
//  RudoUI
//
//  Created by Fernando Salom Carratala on 15/6/23.
//

import Foundation

class RickAndMortyRemoteDataSource: RickAndMortyDataSourceProtocol {
    var networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }

    func getPagination(for page: Int) async throws -> Pagination? {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character/?page=\(page)") else {
            throw NetworkError.badURL
        }
        let request = URLRequest(url: url)
        let paginationDTO = try await networkManager.call(this: request,
                                                          of: PaginationDTO.self)
        return Pagination(dto: paginationDTO)
    }

    func getPaginationWhenSearching(this name: String, for page: Int) async throws -> Pagination? {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character/?name=\(name)&page=\(page)") else {
            throw NetworkError.badURL
        }
        let request = URLRequest(url: url)
        let paginationDTO = try await networkManager.call(this: request,
                                                          of: PaginationDTO.self)
        return Pagination(dto: paginationDTO)
    }
}
