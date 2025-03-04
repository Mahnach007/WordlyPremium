//
//  ContentView.swift
//  WordlyPremium
//
//  Created by Vlad Gotovchykov on 03/03/25.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        ScrollView {
            VStack(spacing: -20) {
                AddButtonView()
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding()
                SearchBar()
                    .padding()
            }
            .padding(.bottom, -30)
            VStack(spacing: -10) {
                PackSliderView(packTitle: "Your Packs", packNumber: 34)
                PackSliderView(packTitle: "Your Folders", packNumber: 10)
                PackSliderView(packTitle: "Community Packs", packNumber: 4)
            }
        }
    }
}

#Preview {
    ContentView()
}
