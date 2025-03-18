//
//  CardSlider.swift
//  Wordly
//
//  Created by Diego Arroyo on 28/02/25.
//

import SwiftUI

struct CardSlider: View {
    var packTitle: String
    var packNumber: Int
    var cards: [CardButtonData]
    var hasData: Bool
    var isFolder: Bool

    @State private var navigateToCreateFolder = false
    @State private var navigateToCreateCards = false
    @State private var navigateToPack = false
    @State private var selectedDestination: DestinationType? = nil
    @State private var isPressed: Bool = false
    @State private var color: Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                SliderTitle(
                    sliderTitle: packTitle, sliderNumber: packNumber,
                    seeAllDestination: AnyView(CardList(isForFolder: false))
                )
                .padding(.horizontal)
                .padding(.vertical, 2)
                if hasData {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(cards) { card in
                                NavigationLink(destination: PackView()) {
                                    CardButton(
                                        cardTitle: card.title,
                                        numberOfWords: card.numberOfWords,
                                        icon: card.icon
                                    )
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.vertical, 7)
                        .padding(.horizontal)
                    }
                } else {
                    Button(action: {
                        if isFolder {
                            navigateToCreateFolder = true
                            print("folder create button")
                        } else {
                            navigateToCreateCards = true
                            print("pack create button")
                        }
                    }) {
                        HStack {
                            Text(
                                isFolder
                                    ? Image(systemName: "folder.badge.plus")
                                    : Image(systemName: "plus.app")
                            )
                            .fontWeight(.bold)
                            Text(
                                isFolder
                                    ? "Create new folder" : "Create new deck")
                        }
                    }
                    .padding(.vertical, 20)
                    .font(.custom("Feather", size: 16))
                    .foregroundStyle(Color.rhino)
                    .background {
                        NavigationLink(
                            destination: CreateFolderView(),
                            isActive: $navigateToCreateFolder
                        ) {
                            EmptyView()
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .sheet(isPresented: $navigateToCreateCards) {
                        AddPackModalView(
                            isPresented: $navigateToCreateCards,
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
                        /// for testing, if this false is changed to true, also change it in ModalViews
                        tag: .secondOption(isAIGenerated: false),
                        selection: $selectedDestination
                    ) { EmptyView() }
                    NavigationLink(
                        destination: selectedDestination?.view,
                        tag: .thirdOption, selection: $selectedDestination
                    ) { EmptyView() }
                }
            }
        }
    }
}

#Preview {
    CardSlider(
        packTitle: "Your Packs", packNumber: 34,
        cards: [
            CardButtonData(
                title: "Car transport only nouns", numberOfWords: 20,
                icon: "cards"),
            CardButtonData(
                title: "Medicine", numberOfWords: 133, icon: "cards"),
            CardButtonData(
                title: "Sports", numberOfWords: 40, icon: "cards"),
            CardButtonData(
                title: "Law", numberOfWords: 10, icon: "cards"),
        ],
        hasData: false,
        isFolder: true
    )
}
