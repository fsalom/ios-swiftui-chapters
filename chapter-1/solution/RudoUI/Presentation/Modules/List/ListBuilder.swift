//
//  ListBuilder.swift
//  RudoUI
//
//  Created by Fernando Salom Carratala on 15/6/23.
//

import Foundation

class ListBuilder {
    func build() -> ListView<ListViewModel> {
        let networkDataSource = RMRemoteDataSource(networkManager: NetworkManager())
        let repository = CharacterRepository(networkDatasource: networkDataSource,
                                             localDatasource: networkDataSource,
                                             cacheManager: networkDataSource)
        let useCase = CharacterUseCase(repository: repository)

        let viewModel = ListViewModel(useCase: useCase)
        let view = ListView(viewModel: viewModel)
        return view
    }
}
