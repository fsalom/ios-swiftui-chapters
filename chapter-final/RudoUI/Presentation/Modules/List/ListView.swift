//
//  ListView.swift
//  RudoUI
//
//  Created by Fernando Salom Carratala on 15/6/23.
//

import SwiftUI

struct ListView<VM>: View where VM: ListViewModelProtocol {
    @ObservedObject var viewModel: VM

    var body: some View {
        VStack {
            NavigationStack {
                VStack {
                    Text("\(viewModel.characters.count)").font(.headline).fontWeight(.black)
                        .foregroundColor(.black)
                    Text("Personajes").font(.footnote)
                        .foregroundColor(.black)
                }
                .frame(maxWidth: .infinity, minHeight: 44)
                .padding(10)
                .background(Color(Resources.Colors.background.rawValue))

                ScrollView {
                    ForEach(viewModel.characters) { character in
                        NavigationLink(destination:  DetailCharacterBuilder().build(with: character)) {
                            CharacterRow(character: character)
                                .padding(.trailing, 20)
                                .padding(.leading, 20)
                        }
                    }
                    if viewModel.hasMoreCharactersPendingToLoad {
                        Button {
                            viewModel.loadMoreIfNeeded()
                        } label: {
                            Text("Cargar más")
                        }
                        .frame(maxWidth: .infinity, minHeight: 44)
                        .background(Color.black)
                        .foregroundColor(.white)
                    }
                }.searchable(text: $viewModel.searchText)
            }
        }.task {
            await viewModel.load()
        }.edgesIgnoringSafeArea(.all)
            .navigationTitle("Lista de personajes")
            .accentColor(.black)
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListBuilder().build()
    }
}
