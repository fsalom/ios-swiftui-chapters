//
//  DetailCharacterBuilder.swift
//  RudoUI
//
//  Created by Fernando Salom Carratala on 16/6/23.
//

import Foundation

class DetailCharacterBuilder {
    func build(with character: RMCharacter) -> DetailCharacterView<DetailCharacterViewModel> {
        let networkDataSource = RMRemoteDataSource(networkManager: NetworkManager())
        let repository = CharacterRepository(networkDatasource: networkDataSource,
                                             cacheDatasource: networkDataSource)
        let useCase = CharacterUseCase(repository: repository)

        let viewModel = DetailCharacterViewModel(useCase: useCase, character: character)
        let view = DetailCharacterView(viewModel: viewModel)
        return view
    }
}
