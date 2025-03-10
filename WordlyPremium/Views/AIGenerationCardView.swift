//
//  AIGenerationCardView.swift
//  WordlyPremium
//
//  Created by Diego Arroyo on 07/03/25.
//

import SwiftUI

struct AIGenerationCardView: View {
    @Environment(\.dismiss) var dismiss
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 20c26cb (complete ai card generation ui)
    @State private var selectedWordOption: WordType? = nil
    @State private var selectedFrontLanguageOption: LanguageType? = nil
    @State private var selectedBackLanguageOption: LanguageType? = nil
    @State private var wordTypeIsVisible = true

<<<<<<< HEAD
=======
    
>>>>>>> c179555 (add ai card generation view)
=======
>>>>>>> 20c26cb (complete ai card generation ui)
    var body: some View {
        VStack(spacing: 20) {
            VStack(alignment: .leading) {
                Text("Topic/Prompt*")
                TextArea()
            }
            VStack(alignment: .leading) {
                Text("Card type")
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 20c26cb (complete ai card generation ui)
                SelectorWithModal<WordType>(
                    selectedOption: $selectedWordOption,
                    selectionType: .wordType
                )
<<<<<<< HEAD
=======
                SelectorWithModal(modalType: 0)
>>>>>>> c179555 (add ai card generation view)
=======
>>>>>>> 20c26cb (complete ai card generation ui)
            }
            VStack(alignment: .leading) {
                Text("Amount of cards")
                NumericField()
            }
            HStack {
                VStack(alignment: .leading) {
                    Text("Front side")
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 20c26cb (complete ai card generation ui)
                    SelectorWithModal<LanguageType>(
                        selectedOption: $selectedFrontLanguageOption,
                        selectionType: .languageType
                    )
<<<<<<< HEAD
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
=======
                    SelectorWithModal(modalType: 1)
=======
>>>>>>> 20c26cb (complete ai card generation ui)
                }
                VStack(alignment: .leading) {
                    Text("Back side")
                    SelectorWithModal<LanguageType>(
                        selectedOption: $selectedBackLanguageOption,
                        selectionType: .languageType
                    )
                }
            }
<<<<<<< HEAD
            VStack(alignment: .leading) {
                Text("Word type")
                HStack {
                    SingleButton(word: "Noun")
                    SingleButton(word: "Verb")
                    SingleButton(word: "Adjective")
                    SingleButton(word: "Adverb")
>>>>>>> c179555 (add ai card generation view)
=======
            if !wordTypeIsVisible {
                VStack(alignment: .leading) {
                    Text("Word type")
                    HStack {
                        SingleButton(word: "Noun")
                        SingleButton(word: "Verb")
                        SingleButton(word: "Adjective")
                        SingleButton(word: "Adverb")
                    }
>>>>>>> 20c26cb (complete ai card generation ui)
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
<<<<<<< HEAD
<<<<<<< HEAD
                            .foregroundStyle(Color.eel)
=======
                            .foregroundStyle(AppColors.eel)
>>>>>>> c179555 (add ai card generation view)
=======
                            .foregroundStyle(Color.eel)
>>>>>>> 20c26cb (complete ai card generation ui)
                    }
                }
            }
            ToolbarItem(placement: .principal) {
                Text("AI Card Generation")
<<<<<<< HEAD
<<<<<<< HEAD
                    .foregroundStyle(Color.eel)
=======
                    .foregroundStyle(AppColors.eel)
>>>>>>> c179555 (add ai card generation view)
=======
                    .foregroundStyle(Color.eel)
>>>>>>> 20c26cb (complete ai card generation ui)
                    .font(.custom("Feather", size: 24))
            }
        }
        .padding(.vertical, -50)
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 20c26cb (complete ai card generation ui)
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
<<<<<<< HEAD
=======
>>>>>>> c179555 (add ai card generation view)
=======
>>>>>>> 20c26cb (complete ai card generation ui)
    }
}

#Preview {
    AIGenerationCardView()
}
