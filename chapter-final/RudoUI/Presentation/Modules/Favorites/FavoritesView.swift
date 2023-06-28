//
//  FavoritesView.swift
//  RudoUI
//
//  Created by Fernando Salom Carratala on 28/6/23.
//

import SwiftUI

struct FavoritesView<VM>: View where VM: FavoritesViewModelProtocol {
    @ObservedObject var viewModel: VM

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesBuilder().build()
    }
}
