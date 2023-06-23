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
                            CharacterRow(character: character)
                                .padding(.trailing, 20)
                                .padding(.leading, 20)

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
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListBuilder().build()
    }
}
