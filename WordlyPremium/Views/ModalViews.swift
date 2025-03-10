//
//  AddPackView.swift
//  WordlyPremium
//
//  Created by Diego Arroyo on 04/03/25.
//

import SwiftUI

struct AddPackModalView: View {
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
                        description: "Generate flashcards instantly", icon: "cards",
                        isGradient: true, isFolder: false
                    )
                    .onTapGesture {
                        selectedDestination = .firstOption
                        isPresented = false
                    }
                    CardButtonExtended(
                        cardTitle: "Photo",
                        description: "Create flashcards from your notes",
                        icon: "cards", isGradient: false, isFolder: false)
                    .onTapGesture {
                        selectedDestination = .secondOption
                        isPresented = false
                    }
                    CardButtonExtended(
                        cardTitle: "Manual Flashcards",
                        description: "Create your own flashcards", icon: "cards",
                        isGradient: false, isFolder: false)
                    .onTapGesture {
                        selectedDestination = .thirdOption
                        isPresented = false
                    }
                }
                .padding()
            }
        }
    }
}

struct SelectWordTypeInModalView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var isPresented: Bool
    @Binding var selectedOption: WordType?

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 18) {
                CardButtonExtended(
                    cardTitle: "Single Word",
                    description: "Car | Apple", icon: "cards",
                    isGradient: false, isFolder: false
                )
                .onTapGesture {
                    selectedOption = .firstOption
                    isPresented = false
                }
                CardButtonExtended(
                    cardTitle: "Phrase",
                    description: "I love you | Good morning",
                    icon: "cards", isGradient: false, isFolder: false)
                .onTapGesture {
                    selectedOption = .secondOption
                    isPresented = false
                }
                CardButtonExtended(
                    cardTitle: "Full Sentence",
                    description: "Where can I buy apples?", icon: "cards",
                    isGradient: false, isFolder: false)
                .onTapGesture {
                    selectedOption = .thirdOption
                    isPresented = false
                }
                CardButtonExtended(
                    cardTitle: "Mixed",
                    description: "All types of cards", icon: "cards",
                    isGradient: false, isFolder: false)
                .onTapGesture {
                    selectedOption = .fourthOption
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
                    isChecked: selected == .firstOption
                )
                .onTapGesture {
                    selectedOption = .firstOption
                    selected = .firstOption
                    isPresented = false
                }
                ButtonWithImage(
                    cardTitle: "Ukranian", icon: "ua",
                    isGradient: false,
                    isChecked: selected == .secondOption
                )
                .onTapGesture {
                    selectedOption = .secondOption
                    selected = .secondOption
                    isPresented = false
                }
                ButtonWithImage(
                    cardTitle: "Italian", icon: "it",
                    isGradient: false,
                    isChecked: selected == .thirdOption
                )
                .onTapGesture {
                    selectedOption = .thirdOption
                    selected = .thirdOption
                    isPresented = false
                }
            }
            .padding()
        }
    }
}

#Preview {
    AIGenerationCardView()
}
