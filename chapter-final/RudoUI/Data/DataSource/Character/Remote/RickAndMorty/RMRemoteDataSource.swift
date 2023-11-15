//
//  RickAndMortyRemoteDataSource.swift
//  RudoUI
//
//  Created by Fernando Salom Carratala on 15/6/23.
//

import Foundation

class RMRemoteDataSource: RMCharacterDataSourceProtocol {
    var networkManager: RemoteManagerProtocol

    init(networkManager: RemoteManagerProtocol) {
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

    func getFavorites() async throws -> [Character] { return [] }

    func saveFavorite(_ character: Character) async throws { }

    func removeFavorite(_ character: Character) async throws { }
}
