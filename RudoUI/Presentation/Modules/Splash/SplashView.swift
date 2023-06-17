//
//  SplashView.swift
//  RudoUI
//
//  Created by Fernando Salom Carratala on 16/6/23.
//

import SwiftUI

struct SplashView: View {

    @State var isActive: Bool = false

    var body: some View {
        ZStack {
            Color.init("backgroundColor")
            if self.isActive {
                ListBuilder().build()
            } else {
                Image("logo")
                    .scaledToFit()
                    .frame(width: 300, height: 150)
                }
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                withAnimation {
                    self.isActive = true
                }
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}