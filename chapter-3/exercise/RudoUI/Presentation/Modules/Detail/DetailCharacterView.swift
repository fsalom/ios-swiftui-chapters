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
        Text("Fix this")
    }

    func getStatusColor(for status: RMCharacter.RMStatus) -> Color {
        switch status {
        case .Dead:
            return .red
        case .Alive:
            return .green
        case .unknown:
            return .gray
        }
    }
}

struct DetailCharacterView_Previews: PreviewProvider {
    static var previews: some View {
        DetailCharacterBuilder().build(with: RMCharacter())
    }
}
