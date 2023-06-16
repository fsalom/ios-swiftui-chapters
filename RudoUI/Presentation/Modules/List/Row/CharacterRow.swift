//
//  CharacterRow.swift
//  RudoUI
//
//  Created by Fernando Salom Carratala on 16/6/23.
//

import SwiftUI

struct CharacterRow: View {
    var character: RMCharacter

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CharacterRow_Previews: PreviewProvider {
    static var previews: some View {
        let character = RMCharacter()
        CharacterRow(character: character)
    }
}
