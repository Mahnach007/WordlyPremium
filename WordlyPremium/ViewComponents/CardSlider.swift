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
    var packs: [PackEntity]?
    var folders: [FolderEntity]?
    var hasData: Bool
    var isFolder: Bool

    @State private var navigateToCreateFolder = false
    @State private var navigateToCreatePack = false
    @State private var navigateToAllPacks = true
    @State private var navigateToFolder = false
    @State private var selectedDestination: DestinationType? = nil
    @State private var isPressed: Bool = false
    @State private var color: Bool = false
    @State private var folderName: String = ""

    var body: some View {
        VStack {
            SliderTitle(
                sliderTitle: packTitle, sliderNumber: packNumber,
                seeAllDestination: AnyView(
                    CardListView(
                        title: packs != nil ? "Your packs" : "Your folders",
                        isFolderList: isFolder,
                        packs: packs != nil ? packs : nil,
                        folders: folders != nil ? folders : nil))
            )
            .padding(.horizontal)
            .padding(.vertical, 2)
            if hasData {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        if packs != nil {
                            ForEach(packs ?? []) {
                                pack in
                                NavigationLink(
                                    destination: PackView(
                                        pack: pack)
                                ) {
                                    CardButton(
                                        cardTitle: pack.name,
                                        numberOfWords: pack.flashcards.count,
                                        icon: "cards"
                                    )
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        } else if folders != nil {
                            ForEach(
                                folders ?? [FolderEntity(name: "Folder")]
                            ) { folder in
                                NavigationLink(
                                    destination: CardListView(
                                        title: folder.name, isFolderList: false)
                                ) {
                                    CardButton(
                                        cardTitle: folder.name,
                                        numberOfWords: folder.packs.count,
                                        icon: "folder"
                                    )
                                }
                                .buttonStyle(PlainButtonStyle())
                                .onTapGesture {
                                    folderName = folder.name
                                }
                            }
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
                        navigateToCreatePack = true
                        print("pack create button")
                    }
                }) {
                    HStack {
                        if isFolder {
                            Image(systemName: "folder.badge.plus")
                        } else {
                            Image(systemName: "plus.app")
                        }
                        Text(isFolder ? "Create new folder" : "Create new deck")
                    }
                }
                .padding(.vertical, 20)
                .font(.custom("Feather", size: 16))
                .foregroundStyle(Color.rhino)
                .background(
                    NavigationLink(
                        destination: FolderCreationView(),
                        isActive: $navigateToCreateFolder,
                        label: { EmptyView() }
                    )
                )
                .sheet(isPresented: $navigateToCreatePack) {
                    AddPackInModalView(
                        isPresented: $navigateToCreatePack,
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

#Preview {
    CardSlider(
        packTitle: "Your Packs",
        packNumber: 2,
        packs: [
            PackEntity(
                name: "Spanish Pack", isAIGenerated: false, langFrom: LanguageType.english, langTo: LanguageType.italian,
                flashcards: [
                    FlashcardEntity(
                        question: "Hello", answer: "Hola", isStudied: true),
                    FlashcardEntity(
                        question: "Goodbye", answer: "Adiós", isStudied: false),
                    FlashcardEntity(
                        question: "Please", answer: "Por favor", isStudied: true
                    ),
                    FlashcardEntity(
                        question: "Thank you", answer: "Gracias",
                        isStudied: true),
                    FlashcardEntity(
                        question: "Yes", answer: "Sí", isStudied: false),
                    FlashcardEntity(
                        question: "No", answer: "No", isStudied: false),
                    FlashcardEntity(
                        question: "Excuse me", answer: "Perdón", isStudied: true
                    ),
                    FlashcardEntity(
                        question: "Sorry", answer: "Lo siento", isStudied: true),
                ]),
            PackEntity(
                name: "French Pack", isAIGenerated: true, langFrom: LanguageType.english, langTo: LanguageType.italian,
                flashcards: [
                    FlashcardEntity(
                        question: "Hello", answer: "Bonjour", isStudied: false),
                    FlashcardEntity(
                        question: "Goodbye", answer: "Au revoir",
                        isStudied: true),
                    FlashcardEntity(
                        question: "Please", answer: "S'il vous plaît",
                        isStudied: false),
                    FlashcardEntity(
                        question: "Thank you", answer: "Merci", isStudied: true),
                    FlashcardEntity(
                        question: "Yes", answer: "Oui", isStudied: false),
                    FlashcardEntity(
                        question: "No", answer: "Non", isStudied: true),
                    FlashcardEntity(
                        question: "Excuse me", answer: "Excusez-moi",
                        isStudied: true),
                    FlashcardEntity(
                        question: "Sorry", answer: "Désolé", isStudied: true),
                ]),
        ],
        //        folders: [
        //            FolderEntity(name: "Folder 1"),
        //            FolderEntity(name: "Folder 2"),
        //            FolderEntity(name: "Folder 3"),
        //        ],
        hasData: true,
        isFolder: true
    )
}
