//
//  ContentView.swift
//  WordlyPremium
//
//  Created by Vlad Gotovchykov on 03/03/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PackSliderViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: -20) {
                AddButton()
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding()
                SearchBar()
                    .padding()
            }
            .padding(.bottom, -30)
            VStack(spacing: -10) {
                PackSlider(
                    packTitle: "Your Packs", packNumber: viewModel.packs.count,
                    cards: viewModel.packs)
                PackSlider(
                    packTitle: "Your Folders",
                    packNumber: viewModel.folders.count,
                    cards: viewModel.folders)
                PackSlider(
                    packTitle: "Community Packs",
                    packNumber: viewModel.community.count,
                    cards: viewModel.community)
            }
        }
    }
}

#Preview {
    ContentView()
}
