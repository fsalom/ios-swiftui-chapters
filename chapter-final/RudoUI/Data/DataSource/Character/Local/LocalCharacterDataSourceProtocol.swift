//
//  LocalCharacterDataSourceProtocol.swift
//  RudoUI
//
//  Created by Fernando Salom Carratala on 14/11/23.
//

import Foundation

protocol LocalCharacterDataSourceProtocol {
    func getPagination(for page: Int) async throws -> Pagination?
    func getPaginationWhenSearching(this name: String, for page: Int) async throws -> Pagination?
    func getFavorites() async throws -> [Character]
    func saveFavorite(_ character: Character)  async throws
    func removeFavorite(_ character: Character)  async throws
}
