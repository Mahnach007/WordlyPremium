//
//  CardList.swift
//  WordlyPremium
//
//  Created by Diego Arroyo on 04/03/25.
//

import SwiftUI

struct CardList: View {
    @Environment(\.dismiss) var dismiss
    @State private var navigateToCreateFolder = false
    @State private var navigateToCreateCards = false
    var isForFolder: Bool

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(isForFolder ? "Your Folders" : "Your Packs")
                    .font(.custom("Feather", size: 32))
                SearchBar()
            }
            .padding(.bottom, 15)
            ScrollView(.vertical) {
                VStack(spacing: 10) {
                    CardButtonExtended(
                        cardTitle: "Car transport only nouns", description: "20 words", icon: "cards", isGradient: false, hasIcon: true)
                    CardButtonExtended(
                        cardTitle: "Medicine", description: "133 words", icon: "cards", isGradient: false, hasIcon: true)
                    CardButtonExtended(
                        cardTitle: "Sports", description: "60 words", icon: "cards", isGradient: false, hasIcon: true)
                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
        .navigationBarBackButtonHidden(true)
        .regainSwipeBack()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    HStack {
                        Text(Image(systemName: "arrow.left"))
                            .fontWeight(.bold)
                            .foregroundStyle(Color.eel)
                    }
                }
            }
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button(action: {
                    
                }) {
                    HStack {
                        Text(Image(systemName: "ellipsis"))
                            .fontWeight(.bold)
                            .foregroundStyle(Color.eel)
                    }
                }
                Button(action: {
                    if isForFolder {
                        navigateToCreateFolder = true
                    } else {
                        navigateToCreateCards = true
                    }
                }) {
                    HStack {
                        Text(Image(systemName: "plus"))
                            .fontWeight(.bold)
                            .foregroundStyle(Color.eel)
                    }
                }
            }
        }
        NavigationLink(
            destination: CreateFolderView(),
            isActive: $navigateToCreateFolder,
            label: { EmptyView() }
        )
        NavigationLink(
            destination: AIGenerationCardView(),
            isActive: $navigateToCreateCards,
            label: { EmptyView() }
        )
    }
}

#Preview {
    CardList(isForFolder: false)
}

#Preview {
    CardList(isForFolder: false)
}

#Preview {
    ContentView()
}

