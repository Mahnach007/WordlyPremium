//
//  ModalViews.swift
//  WordlyPremium
//
//  Created by Diego Arroyo on 04/03/25.
//

import SwiftUI

struct AddPackInModalView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var isPresented: Bool
    @Binding var selectedDestination: DestinationType?

    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            NavigationView {
                VStack(alignment: .leading, spacing: 18) {
                    CardButtonExtended(
                        cardTitle: "AI Flashcards",
                        description: "Generate flashcards instantly",
                        icon: "cards",
                        isGradient: true, hasIcon: false
                    )
                    .onTapGesture {
                        selectedDestination = .firstOption
                        isPresented = false
                    }
                    CardButtonExtended(
                        cardTitle: "Manual Flashcards",
                        description: "Create your own flashcards",
                        icon: "handWithPen",
                        isGradient: false, hasIcon: true
                    )
                    .onTapGesture {
                        /// for testing, if this false is changed to true, also change it in ContentView
                        selectedDestination = .secondOption(
                            isAIGenerated: false)
                        isPresented = false
                    }
                    CardButtonExtended(
                        cardTitle: "Create Folder",
                        description: "Store your packs in one place",
                        icon: "folder", isGradient: false, hasIcon: true
                    )
                    .onTapGesture {
                        selectedDestination = .thirdOption
                        isPresented = false
                    }
                }
                .navigationBarBackButtonHidden(true)
                .padding()
            }
        }
    }
}

struct SelectWordTypeInModalView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var isPresented: Bool
    @Binding var selectedOption: CardType?

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 18) {
                CardButtonExtended(
                    cardTitle: "Single Word",
                    description: "Car | Apple", icon: "cards",
                    isGradient: false, hasIcon: false
                )
                .onTapGesture {
                    selectedOption = .singleWord
                    isPresented = false
                }
                CardButtonExtended(
                    cardTitle: "Phrase",
                    description: "I love you | Good morning",
                    icon: "cards", isGradient: false, hasIcon: false
                )
                .onTapGesture {
                    selectedOption = .phrase
                    isPresented = false
                }
                CardButtonExtended(
                    cardTitle: "Full Sentence",
                    description: "Where can I buy apples?", icon: "cards",
                    isGradient: false, hasIcon: false
                )
                .onTapGesture {
                    selectedOption = .sentence
                    isPresented = false
                }
                CardButtonExtended(
                    cardTitle: "Mixed",
                    description: "All types of cards", icon: "cards",
                    isGradient: false, hasIcon: false
                )
                .onTapGesture {
                    selectedOption = .mixed
                    isPresented = false
                }
            }
            .padding()
        }
    }
}

struct SelectLanguageInModalView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var isPresented: Bool
    @Binding var selectedOption: LanguageType?
    @State var selected: LanguageType?

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 18) {
                ButtonWithImage(
                    cardTitle: "English", icon: "gb",
                    isGradient: false,
                    isChecked: selected == .english
                )
                .onTapGesture {
                    selectedOption = .english
                    selected = .english
                    isPresented = false
                }
                ButtonWithImage(
                    cardTitle: "Ukranian", icon: "ua",
                    isGradient: false,
                    isChecked: selected == .ukrainian
                )
                .onTapGesture {
                    selectedOption = .ukrainian
                    selected = .ukrainian
                    isPresented = false
                }
                ButtonWithImage(
                    cardTitle: "Italian", icon: "it",
                    isGradient: false,
                    isChecked: selected == .italian
                )
                .onTapGesture {
                    selectedOption = .italian
                    selected = .italian
                    isPresented = false
                }
            }
            .padding()
        }
    }
}

#Preview {
    FlashcardAIGenView()
}
