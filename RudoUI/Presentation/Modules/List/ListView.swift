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
                ScrollView {
                    ForEach(viewModel.characters) { character in
                        NavigationLink(destination:  DetailCharacterBuilder().build(with: character)) {
                            CharacterRow(character: character)
                                .padding(.trailing, 20)
                                .padding(.leading, 20)
                        }
                    }
                }
            }
        }.onAppear {
            viewModel.load()
        }.edgesIgnoringSafeArea(.all)
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListBuilder().build()
    }
}
