//
//  ContentView.swift
//  WordlyPremium
//
//  Created by Vlad Gotovchykov on 03/03/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var folderViewModel = AddFolderViewModel()
    @StateObject private var packViewModel = AddPackViewModel()
    @State private var isModalPresented = false
    @State private var selectedDestination: DestinationType? = nil

    var body: some View {
        ZStack {
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
                                AddPackInModalView(
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
                            packNumber: packViewModel.packs.count,
                            packs: packViewModel.packs,
                            /// Note the negation here
                            hasData: !packViewModel.packs.isEmpty,
                            isFolder: false
                        )
                        CardSlider(
                            packTitle: "Your Folders",
                            packNumber: folderViewModel.folders.count,
                            folders: folderViewModel.folders,
                            /// Note the negation here
                            hasData: !folderViewModel.folders.isEmpty,
                            isFolder: true
                        )
                        //                        CardSlider(
                        //                            packTitle: "Community Packs",
                        //                            packNumber: cardViewModel.community.count,
                        //                            cards: cardViewModel.community,
                        //                            hasData: true,
                        //                            isFolder: false
                        //                        )
                    }
                    .padding(.top, 20)
                }
                .background(Color.background)
                .navigationDestination(item: $selectedDestination) {
                    destination in
                    destination.view
                }
                .onAppear {
                    folderViewModel.refreshFolders()
                    packViewModel.refreshPacks()
                    print(packViewModel.packs)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
