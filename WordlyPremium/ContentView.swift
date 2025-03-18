//
//  ContentView.swift
//  WordlyPremium
//
//  Created by Vlad Gotovchykov on 03/03/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PackSliderViewModel()
    @State private var isModalPresented = false
    @State private var selectedDestination: DestinationType? = nil

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HStack {
                    AddButton(isRounded: false)
                        .padding()
                        .padding(.vertical, -25)
                        .padding(.top, 20)
                        .onTapGesture {
                            isModalPresented = true
                        }
                        .sheet(isPresented: $isModalPresented) {
                            AddPackModalView(
                                isPresented: $isModalPresented,
                                selectedDestination: $selectedDestination
                            )
                            .presentationBackground(Color.background)
                            .presentationDetents([.fraction(0.5)])
                            .presentationDragIndicator(.visible)
                        }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                SearchBar()
                    .padding()
            }
            .background(Color.background)
            .padding(.bottom, -10)
            ScrollView {
                VStack(spacing: 35) {
                    CardSlider(
                        packTitle: "Your Packs",
                        packNumber: viewModel.packs.count,
                        cards: viewModel.packs,
                        hasData: true,
                        isFolder: false
                    )
                    CardSlider(
                        packTitle: "Your Folders",
                        packNumber: viewModel.folders.count,
                        cards: viewModel.folders,
                        hasData: false,
                        isFolder: true
                    )
                    CardSlider(
                        packTitle: "Community Packs",
                        packNumber: viewModel.community.count,
                        cards: viewModel.community,
                        hasData: true,
                        isFolder: false
                    )
                }
                .padding(.top, 20)
            }
            .background(Color.background)
            NavigationLink(value: selectedDestination) {
                EmptyView()
            }
            .navigationDestination(item: $selectedDestination) { destination in
                destination.view
            }
        }
    }
}

#Preview {
    ContentView()
}
