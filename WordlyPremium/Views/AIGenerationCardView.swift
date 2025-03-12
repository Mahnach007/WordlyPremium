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
<<<<<<< HEAD
=======
>>>>>>> 20c26cb (complete ai card generation ui)
    @State private var selectedWordOption: WordType? = nil
=======
    // Parameters
    @State private var selectedCardOption: CardType? = nil
>>>>>>> c34d0a7 (refactor card generation models and update button actions for improved flexibility.)
    @State private var selectedFrontLanguageOption: LanguageType? = nil
    @State private var selectedBackLanguageOption: LanguageType? = nil
    @State private var topic = ""
    @State private var cardAmount: String = ""
    @State private var wordType: WordType? = nil
    @State private var selectedWordTypes: Set<String> = []
    @State private var flashcards: [Flashcard] = []
    
    @State private var isLoading = false
    @State private var errorMessage: String?
    @State private var wordTypeIsVisible = true
<<<<<<< HEAD

<<<<<<< HEAD
=======
    
>>>>>>> c179555 (add ai card generation view)
=======
>>>>>>> 20c26cb (complete ai card generation ui)
=======
    
    private let flashcardService = FlashcardService()
    
>>>>>>> c34d0a7 (refactor card generation models and update button actions for improved flexibility.)
    var body: some View {
        VStack(spacing: 20) {
//            Topic
            VStack(alignment: .leading) {
                Text("Topic/Prompt*")
                TextArea(inputText: $topic)
            }
//            Card Type
            VStack(alignment: .leading) {
                Text("Card type")
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 20c26cb (complete ai card generation ui)
                SelectorWithModal<WordType>(
                    selectedOption: $selectedWordOption,
                    selectionType: .wordType
=======
                SelectorWithModal<CardType>(
                    selectedOption: $selectedCardOption,
                    selectionType: .cardType
>>>>>>> c34d0a7 (refactor card generation models and update button actions for improved flexibility.)
                )
<<<<<<< HEAD
=======
                SelectorWithModal(modalType: 0)
>>>>>>> c179555 (add ai card generation view)
=======
>>>>>>> 20c26cb (complete ai card generation ui)
            }
//            Amount of Cards
            VStack(alignment: .leading) {
                Text("Amount of cards")
                NumericField(inputText: $cardAmount)
            }
//            Lang
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
//            Word Type
            if !wordTypeIsVisible {
                VStack(alignment: .leading) {
                    Text("Word type")
                    HStack {
                        ForEach(WordType.allCases, id: \.self) { word in
                            SingleButton(word: word.rawValue, onTap: {
                                if selectedWordTypes.contains(word.rawValue) {
                                    selectedWordTypes.remove(word.rawValue)
                                } else {
                                    selectedWordTypes.insert(word.rawValue)
                                }
                            }).tag(word.rawValue)
                        }
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
            ConfirmButton(cardTitle: "Generate", icon: "generate", action: generateFlashcards)
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
<<<<<<< HEAD
=======
>>>>>>> 20c26cb (complete ai card generation ui)
        .onChange(of: selectedWordOption) {
            if let newValue = selectedWordOption {
                if newValue == .firstOption {
=======
        .onChange(of: selectedCardOption) {
            if let newValue = selectedCardOption {
                if newValue == .singleWord {
>>>>>>> c34d0a7 (refactor card generation models and update button actions for improved flexibility.)
                    wordTypeIsVisible = false
                } else {
                    wordTypeIsVisible = true
                }
            }
        }
<<<<<<< HEAD
        .background(Color.background)
<<<<<<< HEAD
=======
>>>>>>> c179555 (add ai card generation view)
=======
>>>>>>> 20c26cb (complete ai card generation ui)
=======
>>>>>>> c34d0a7 (refactor card generation models and update button actions for improved flexibility.)
    }
    
    private func generateFlashcards() {
        isLoading = true
        errorMessage = nil
        
        let request = GenerateCardsRequest(
            fromLanguage: selectedFrontLanguageOption?.rawValue,
            toLanguage: selectedBackLanguageOption?.rawValue,
            topic: topic,
            cardType: selectedCardOption?.rawValue,
            numCards: cardAmount,
            wordTypes: selectedWordTypes
        )
        
        flashcardService.generateCards(request: request) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let cards):
                    flashcards = cards
                case .failure(let error):
                    errorMessage = error.localizedDescription
                }
            }
        }
    }
    
}

#Preview {
    AIGenerationCardView()
}

