//
//  FlashcardAIGenView.swift
//  WordlyPremium
//
//  Created by Diego Arroyo on 07/03/25.
//

import SwiftData
import SwiftUI

struct FlashcardAIGenView: View {
    @Environment(\.dismiss) var dismiss
    
    /// Parameters
    @State private var selectedCardOption: CardType?
    @State private var selectedFrontLanguageOption: LanguageType?
    @State private var selectedBackLanguageOption: LanguageType?
    @State private var topic = ""
    @State private var cardAmount: String = ""
    @State private var wordType: WordType? = nil
    @State private var selectedWordTypes: Set<String> = []
    @State private var flashcards: [FlashcardEntity] = []
    @State private var packTitle: String = ""

    @State private var isLoading = false
    @State private var errorMessage: String?
    @State private var wordTypeIsVisible = true
    @FocusState private var isFocused: Bool

    /// Navigation state
    @State private var navigateToGeneratedCards = false

    private let flashcardService = FlashcardService()

    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                VStack(spacing: 20) {
                    /// Topic
                    VStack(alignment: .leading) {
                        Text("Topic/Prompt*")
                        TextArea(
                            inputText: $topic, isMultiline: true,
                            placeholder: "Enter your prompt..."
                        )
                        .focused($isFocused)
                    }
                    /// Card Type
                    VStack(alignment: .leading) {
                        Text("Card type")
                        SelectorWithModal<CardType>(
                            selectedOption: $selectedCardOption,
                            selectionType: .cardType
                        )
                    }
                    /// Amount
                    VStack(alignment: .leading) {
                        Text("Amount of cards (max. 50)")
                        NumericField(inputText: $cardAmount)
                            .focused($isFocused)
                    }
                    /// Front/Back
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Front side*")
                            SelectorWithModal<LanguageType>(
                                selectedOption: $selectedFrontLanguageOption,
                                selectionType: .languageType
                            )
                        }
                        VStack(alignment: .leading) {
                            Text("Back side*")
                            SelectorWithModal<LanguageType>(
                                selectedOption: $selectedBackLanguageOption,
                                selectionType: .languageType
                            )
                        }
                    }
                    /// Word Type (conditional inside the main VStack)
                    if !wordTypeIsVisible {
                        VStack(alignment: .leading) {
                            Text("Word type")
                            HStack {
                                ForEach(WordType.allCases, id: \.self) { word in
                                    SingleButton(
                                        word: word.rawValue,
                                        onTap: {
                                            if selectedWordTypes.contains(word.rawValue) {
                                                selectedWordTypes.remove(word.rawValue)
                                            } else {
                                                selectedWordTypes.insert(word.rawValue)
                                            }
                                        }
                                    ).tag(word.rawValue)
                                }
                            }
                        }
                    }
                    Spacer()
                    /// At the bottom, add a progress indicator when loading
                    if isLoading {
                        ProgressView("Generating cards...")
                            .padding()
                    }
                    /// Generate Button
                    ConfirmButton(
                        cardTitle: "Generate", icon: "generate", action: generateFlashcards
                    )
                    .padding(.bottom, 50)
                    .disabled(isLoading)
                }
                .font(.custom("Feather", size: 12))
                .frame(maxHeight: .infinity, alignment: .top)
                .padding()
                
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            isFocused = false  // Dismiss keyboard
                        }
                    }
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
                    ToolbarItem(placement: .principal) {
                        Text("AI Card Generation")
                            .foregroundStyle(Color.eel)
                            .font(.custom("Feather", size: 15))
                    }
                }
                .addLoader($isLoading)
                .navigationBarBackButtonHidden(true)
                .navigationBarTitleDisplayMode(.inline)
                .regainSwipeBack()
                .onChange(of: selectedCardOption) {
//                    if let newValue = selectedCardOption {
                        wordTypeIsVisible = (selectedCardOption != .singleWord)
//                    }
                }
                .navigationDestination(isPresented: $navigateToGeneratedCards) {
                    if let selectedFrontLanguageOption, let selectedBackLanguageOption {
                        FlashcardAIManGenView(
                            flashcards: $flashcards,
                            isAIGenerated: true,
                            titlePlaceholder: packTitle,
                            langFrom: selectedFrontLanguageOption,
                            langTo: selectedBackLanguageOption,
                            onAddFlashcard: {
                                flashcards.append(FlashcardEntity(question: "", answer: "", isStudied: false))
                            }
                        )
                    }
                }
                .alert(
                    "Error",
                    isPresented: .init(
                        get: { errorMessage != nil },
                        set: { if !$0 { errorMessage = nil } }
                    )
                ) {
                    Button("OK") { errorMessage = nil }
                } message: {
                    Text(errorMessage ?? "An unknown error occurred")
                }
            }
        }
    }

    private func generateFlashcards() {
        /// Validate inputs first
        if topic.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errorMessage = "Please enter a topic or prompt"
            return
        }

        /// Ensure language selections are made
        guard let selectedFrontLanguageOption, let selectedBackLanguageOption else {
            errorMessage = "Please select both front and back languages"
            return
        }
        
        guard let selectedCardOption else {
            errorMessage = "Please select a card type"
            return
        }

        /// Set reasonable defaults if needed
        let effectiveCardAmount = cardAmount.isEmpty ? "10" : cardAmount

        /// For single word type, ensure at least one word type is selected
        if selectedCardOption == .singleWord && selectedWordTypes.isEmpty {
            selectedWordTypes.insert("Mixed")  // Default to mixed if nothing selected
        }

        isLoading = true
        errorMessage = nil

        let request = GenerateCardsRequest(
            fromLanguage: selectedFrontLanguageOption.rawValue,
            toLanguage: selectedBackLanguageOption.rawValue,
            topic: topic,
            cardType: selectedCardOption.rawValue,
            numCards: effectiveCardAmount,
            wordTypes: selectedWordTypes
        )
        
//        print("Here is the amount: \(cardAmount)")
//        print("Generating cards with parameters: \(request)")

        flashcardService.generateCards(request: request) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let (cards, packName)):
                    self.packTitle = packName
                    // Convert the Flashcard objects to FlashcardEntity objects if needed
                    self.flashcards = cards.map { card in
                        return FlashcardEntity(
                            question: card.question,
                            answer: card.answer,
                            isStudied: false
                        )
                    }
                    /// Log success
//                  print("Generated \(self.flashcards.count) flashcards successfully")

                    /// Only navigate if we actually got cards
                    if !self.flashcards.isEmpty {
                        navigateToGeneratedCards = true
                    } else {
                        errorMessage =
                            "No flashcards could be generated. Please try different parameters."
                    }

                case .failure(let error):
                    print("Error generating flashcards: \(error.localizedDescription)")
                    errorMessage = error.localizedDescription
                }
            }
        }
    }
}

#Preview {
    FlashcardAIGenView()
}
