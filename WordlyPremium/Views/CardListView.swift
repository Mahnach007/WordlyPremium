//
//  CardListView.swift
//  WordlyPremium
//
//  Created by Diego Arroyo on 04/03/25.
//

import SwiftUI

struct CardListView: View {
    @Environment(\.dismiss) var dismiss
    @State private var navigateToCreateFolder = false
    @State private var navigateToCreateCards = false
    @State private var navigateToPack = false
    @StateObject var folderViewModel: AddFolderViewModel = AddFolderViewModel()
    @StateObject var packViewModel: AddPackViewModel = AddPackViewModel()

    var title: String
    var isFolderList: Bool
    var packs: [PackEntity]?
    var folders: [FolderEntity]?

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
                    if packs != nil {
                        ForEach(packs ?? [PackEntity(name: "Pack")]) { pack in
                            NavigationLink(
                                destination: PackView(
                                    pack: pack)
                            ) {
                                CardButtonExtended(
                                    cardTitle: pack.name,
                                    description: String(pack.flashcardCount)
                                        + " flashcards",
                                    icon: "cards",
                                    isGradient: false,
                                    hasIcon: true,
                                    color: .rhino
                                )
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    } else if folders != nil {
                        ForEach(folders ?? [FolderEntity(name: "Folder")]) {
                            folder in
                            NavigationLink(
                                destination: CardListView(
                                    title: folder.name, isFolderList: false,
                                    packs: folder.packs)
                            ) {
                                CardButtonExtended(
                                    cardTitle: folder.name,
                                    description: String(folder.packs.count),
                                    icon: "folder",
                                    isGradient: false,
                                    hasIcon: true,
                                    color: .rhino
                                )
                            }
                        }
                    }
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
                //                Button(action: {
                //
                //                }) {
                //                    HStack {
                //                        Text(Image(systemName: "ellipsis"))
                //                            .fontWeight(.bold)
                //                            .foregroundStyle(Color.eel)
                //                    }
                //                }
                NavigationLink(
                    destination: (isFolderList
                        ? AnyView(FolderCreationView())
                        : AnyView(FlashcardAIGenView()))
                ) {
                    HStack {
                        Text(Image(systemName: "plus"))
                            .fontWeight(.bold)
                            .foregroundStyle(Color.eel)
                    }
                }
            }
        }
    }
}

#Preview {
    CardListView(
        title: "true", isFolderList: true,
//        packs: [
//            PackEntity(
//                name: "Spanish Pack", isAIGenerated: false,
//                flashcards: [
//                    FlashcardEntity(
//                        question: "Hello", answer: "Hola", isStudied: true),
//                    FlashcardEntity(
//                        question: "Goodbye", answer: "Adiós", isStudied: false),
//                    FlashcardEntity(
//                        question: "Please", answer: "Por favor", isStudied: true
//                    ),
//                    FlashcardEntity(
//                        question: "Thank you", answer: "Gracias",
//                        isStudied: true),
//                    FlashcardEntity(
//                        question: "Yes", answer: "Sí", isStudied: false),
//                    FlashcardEntity(
//                        question: "No", answer: "No", isStudied: false),
//                    FlashcardEntity(
//                        question: "Excuse me", answer: "Perdón", isStudied: true
//                    ),
//                    FlashcardEntity(
//                        question: "Sorry", answer: "Lo siento", isStudied: true),
//                ]),
//            PackEntity(
//                name: "French Pack", isAIGenerated: true,
//                flashcards: [
//                    FlashcardEntity(
//                        question: "Hello", answer: "Bonjour", isStudied: false),
//                    FlashcardEntity(
//                        question: "Goodbye", answer: "Au revoir",
//                        isStudied: true),
//                    FlashcardEntity(
//                        question: "Please", answer: "S'il vous plaît",
//                        isStudied: false),
//                    FlashcardEntity(
//                        question: "Thank you", answer: "Merci", isStudied: true),
//                    FlashcardEntity(
//                        question: "Yes", answer: "Oui", isStudied: false),
//                    FlashcardEntity(
//                        question: "No", answer: "Non", isStudied: true),
//                    FlashcardEntity(
//                        question: "Excuse me", answer: "Excusez-moi",
//                        isStudied: true),
//                    FlashcardEntity(
//                        question: "Sorry", answer: "Désolé", isStudied: true),
//                ]),
//        ],
        folders: [
            FolderEntity(name: "Folder 1"),
            FolderEntity(name: "Folder 2"),
            FolderEntity(name: "Folder 3"),
        ])
}

#Preview {
    ContentView()
}
