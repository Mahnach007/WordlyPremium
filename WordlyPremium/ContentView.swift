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
        ZStack {
            NavigationStack {
                VStack(spacing: 0) {
                    HStack {
                        AddButton()
                            .padding()
                            .padding(.vertical, -30)
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
                        NavigationLink(
                            destination: selectedDestination?.view,
                            tag: .firstOption, selection: $selectedDestination
                        ) { EmptyView() }
                        NavigationLink(
                            destination: selectedDestination?.view,
                            tag: .secondOption, selection: $selectedDestination
                        ) { EmptyView() }
                        NavigationLink(
                            destination: selectedDestination?.view,
                            tag: .thirdOption, selection: $selectedDestination
                        ) { EmptyView() }
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
                            cards: viewModel.packs
                        )
                        CardSlider(
                            packTitle: "Your Folders",
                            packNumber: viewModel.folders.count,
                            cards: viewModel.folders
                        )
                        CardSlider(
                            packTitle: "Community Packs",
                            packNumber: viewModel.community.count,
                            cards: viewModel.community
                        )
                    }
                    .padding(.top, 20)
                }
                .background(Color.background)
            }
        }
    }
}

#Preview {
    ContentView()
}

//@StateObject private var viewModel = PackSliderViewModel()
//@State private var showAddView = false
//
//var body: some View {
//    NavigationStack {
//        VStack {
//            HStack {
//                AddButton()
//                    .padding()
//                    .padding(.vertical, -30)
//                    .padding(.top, 20)
//                    .onTapGesture {
//                        showAddView = true
//                    }
//                    .sheet(isPresented: $showAddView) {
//                        AddPackView()
//                            .presentationDetents([.fraction(0.5)])
//                            .presentationDragIndicator(.visible)
//                    }
//            }
//            .frame(maxWidth: .infinity, alignment: .trailing)
//            SearchBar()
//                .padding()
//        }
//        ScrollView {
//            VStack(spacing: 35) {
//                CardSlider(
//                    packTitle: "Your Packs",
//                    packNumber: viewModel.packs.count,
//                    cards: viewModel.packs
//                )
//                CardSlider(
//                    packTitle: "Your Folders",
//                    packNumber: viewModel.folders.count,
//                    cards: viewModel.folders
//                )
//                CardSlider(
//                    packTitle: "Community Packs",
//                    packNumber: viewModel.community.count,
//                    cards: viewModel.community
//                )
//            }
//            .padding(.top, 20)
//        }
//    }
//}
