//
//  DetailCharacterView.swift
//  RudoUI
//
//  Created by Fernando Salom Carratala on 16/6/23.
//

import SwiftUI

struct DetailCharacterView<VM>: View where VM: DetailCharacterViewModelProtocol {
    @ObservedObject var viewModel: VM
    
    var body: some View {
        VStack {
            if let url = URL(string: viewModel.character.image) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
            }
            Spacer()
            if viewModel.errorOccurred {
                HStack {
                    Text("Error")
                }.padding(16)
                    .frame(maxWidth: .infinity, idealHeight: 80)
                    .background(.red)
            } else {
                VStack(alignment: .leading) {
                    Text("Personajes relacionados")
                        .padding(16)
                        .fontWeight(.bold)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.relatedCharacters) { character in
                                NavigationLink(destination:  DetailCharacterBuilder().build(with: character)) {
                                    RelatedCharacterRow(character: character)
                                }
                            }
                        }.padding(16)
                    }.frame(maxWidth: .infinity, idealHeight: 80)
                        .task {
                            await viewModel.getRelatedCharacters()
                        }
                }

            }
        }.navigationTitle(viewModel.character.name)
    }
}

struct DetailCharacterView_Previews: PreviewProvider {
    static var previews: some View {
        DetailCharacterBuilder().build(with: RMCharacter())
    }
}
