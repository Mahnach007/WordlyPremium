//
//  AIGenerationCardView.swift
//  WordlyPremium
//
//  Created by Diego Arroyo on 07/03/25.
//

import SwiftUI

struct AIGenerationCardView: View {
    @Environment(\.dismiss) var dismiss
    // Parameters
    @State private var selectedCardOption: CardType? = nil
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
    @FocusState private var isFocused: Bool
    
    
    private let flashcardService = FlashcardService()
    
    var body: some View {
        GeometryReader{ geometry in
            VStack(spacing: 20) {
                // Topic
                VStack(alignment: .leading) {
                    Text("Topic/Prompt*")
                    TextArea(inputText: $topic, isMultiline: true, placeholder: "Enter your prompt...")
                        .focused($isFocused)
                }
                // Card Type
                VStack(alignment: .leading) {
                    Text("Card type")
                    SelectorWithModal<CardType>(
                        selectedOption: $selectedCardOption,
                        selectionType: .cardType
                    )
                }
                // Amount
                VStack(alignment: .leading) {
                    Text("Amount of cards")
                    NumericField(inputText: cardAmount)
                        .focused($isFocused)
                }
                // Front/Back
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
                // Word Type (conditional inside the main VStack)
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
                    }
                }
                
                Spacer()
                
                // Generate Button
                ConfirmButton(cardTitle: "Generate", icon: "generate", action: generateFlashcards)
                    .padding(.bottom, 50)
            }
            .font(.custom("Feather", size: 12))
            .frame(maxHeight: .infinity, alignment: .top)
            .padding()
            .toolbar {
                ToolbarItemGroup(placement:.keyboard) {
                                    Spacer()
                                    Button("Done") {
                                        isFocused = false // Dismiss keyboard
                                    }
                                }
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
                        .font(.custom("Feather", size: 15))
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .regainSwipeBack()
            .onChange(of: selectedCardOption) {
                if let newValue = selectedCardOption {
                    wordTypeIsVisible = (newValue != .singleWord)
                }
            }
        }
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

