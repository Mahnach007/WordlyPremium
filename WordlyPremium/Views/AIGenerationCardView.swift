//
//  AIGenerationCardView.swift
//  WordlyPremium
//
//  Created by Diego Arroyo on 07/03/25.
//

import SwiftUI

struct AIGenerationCardView: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedWordOption: WordType? = nil
    @State private var selectedFrontLanguageOption: LanguageType? = nil
    @State private var selectedBackLanguageOption: LanguageType? = nil
    @State private var wordTypeIsVisible = true

    var body: some View {
        VStack(spacing: 20) {
            VStack(alignment: .leading) {
                Text("Topic/Prompt*")
                TextArea()
            }
            VStack(alignment: .leading) {
                Text("Card type")
                SelectorWithModal<WordType>(
                    selectedOption: $selectedWordOption,
                    selectionType: .wordType
                )
            }
            VStack(alignment: .leading) {
                Text("Amount of cards")
                NumericField()
            }
            HStack {
                VStack(alignment: .leading) {
                    Text("Front side")
                    SelectorWithModal<LanguageType>(
                        selectedOption: $selectedFrontLanguageOption,
                        selectionType: .languageType
                    )
                }
                VStack(alignment: .leading) {
                    Text("Back side")
                    SelectorWithModal<LanguageType>(
                        selectedOption: $selectedBackLanguageOption,
                        selectionType: .languageType
                    )
                }
            }
            if !wordTypeIsVisible {
                VStack(alignment: .leading) {
                    Text("Word type")
                    HStack {
                        SingleButton(word: "Noun")
                        SingleButton(word: "Verb")
                        SingleButton(word: "Adjective")
                        SingleButton(word: "Adverb")
                    }
                }
            }
            Spacer()
            ConfirmButton(cardTitle: "Generate", icon: "generate")
                .padding(.bottom, 50)
        }
        .font(.custom("Feather", size: 12))
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
        .navigationBarBackButtonHidden(true)
        .regainSwipeBack()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
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
            ToolbarItem(placement: .principal) {
                Text("AI Card Generation")
                    .foregroundStyle(Color.eel)
                    .font(.custom("Feather", size: 24))
            }
        }
        .padding(.vertical, -50)
        .onChange(of: selectedWordOption) {
            if let newValue = selectedWordOption {
                if newValue == .firstOption {
                    wordTypeIsVisible = false
                } else {
                    wordTypeIsVisible = true
                }
            }
        }
        .background(Color.background)
    }
}

#Preview {
    AIGenerationCardView()
}
