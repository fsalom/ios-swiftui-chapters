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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct DetailCharacterView_Previews: PreviewProvider {
    static var previews: some View {
        DetailCharacterBuilder().build(with: RMCharacter())
    }
}
