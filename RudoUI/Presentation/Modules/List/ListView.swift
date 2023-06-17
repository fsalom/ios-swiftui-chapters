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
        ZStack {
            VStack {
                NavigationStack {
                    ScrollView {
                        ForEach(viewModel.characters) { character in
                            NavigationLink(destination:  DetailCharacterBuilder().build(with: character)) {
                                CharacterRow(character: character)
                                    .padding(.trailing, 20)
                                    .padding(.leading, 20)
                            }
                        }
                        if viewModel.hasNextPage {
                            Button {
                                viewModel.loadMoreIfNeeded()
                            } label: {
                                Text("Cargar más")
                            }
                            .frame(maxWidth: .infinity, minHeight: 44)
                            .background(Color.black)
                            .foregroundColor(.white)
                        }
                    }
                }
            }.task {
                await viewModel.load()
            }.edgesIgnoringSafeArea(.all)

            VStack {
                Text("\(viewModel.characters.count)").font(.headline).fontWeight(.black)
                    .foregroundColor(.white)
                Text("Personajes").font(.footnote)
                    .foregroundColor(.white)
            }
            .frame(width: 90, height: 50)
            .padding(10)
            .background(.black)
            .cornerRadius(10)
            .position(x: UIScreen.main.bounds.width - 40, y: 200)
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListBuilder().build()
    }
}
