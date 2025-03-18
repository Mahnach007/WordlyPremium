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
    @State private var navigateToPack = false
    @StateObject var folderViewModel: AddFolderViewModel = AddFolderViewModel()
    @StateObject var packViewModel: AddPackViewModel = AddPackViewModel()

    var title: String
    var isFolderList: Bool

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.custom("Feather", size: 32))
                SearchBar()
            }
            .padding(.bottom, 15)
            ScrollView(.vertical) {
                VStack(spacing: 10) {
                    ForEach(packViewModel.packs) { pack in
                        CardButtonExtended(
                            cardTitle: pack.name,
                            description: String(pack.flashcardCount),
                            icon: "folder",
                            isGradient: false,
                            hasIcon: true,
                            color: .rhino
                        )
                        .background(
                            NavigationLink(
                                destination: PackView(),
                                isActive: $navigateToPack,
                                label: { EmptyView() }
                            )
                        )
                    }
//                    ForEach(folderViewModel.folders) { folder in
//                        CardButtonExtended(
//                            cardTitle: folder.name,
//                            description: String(folder.packs.count),
//                            icon: "folder",
//                            isGradient: false,
//                            hasIcon: true,
//                            color: .rhino
//                        )
//                        .background(
//                            NavigationLink(
//                                destination: PackView(),
//                                isActive: $navigateToPack,
//                                label: { EmptyView() }
//                            )
//                        )
//                    }
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
                    if isFolderList {
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
    CardList(title: "true", isFolderList: true)
}

#Preview {
    CardList(title: "false", isFolderList: false)
}

#Preview {
    ContentView()
}
