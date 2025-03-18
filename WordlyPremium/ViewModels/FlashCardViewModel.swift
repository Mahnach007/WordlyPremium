//
//  FlashCardViewModel.swift
//  WordlyPremium
//
//  Created by Vlad Gotovchykov on 15/03/25.
//

import AVFoundation
import Foundation

class FlashCardViewModel: ObservableObject {

    private var synthesizer = AVSpeechSynthesizer()

    @Published var rememberedCards: [FlashcardEntity] = []
    @Published var cardsToLearn: [FlashcardEntity] = []
    @Published var currentCards: [FlashcardEntity] = []
    @Published var progress: Double = 0.0
    @Published var isRoundComplete: Bool = false
    @Published var allCardsLearned: Bool = false
    
    var allCards: [FlashcardEntity] = []


    init(flashCards: [FlashcardEntity]) {
        // Initialize with sample cards
        let initialCards = flashCards
        self.allCards = initialCards  // Add this line to initialize allCards
        self.cardsToLearn = []
        self.currentCards = initialCards
        updateProgress()
    }

    func speak(word: String, language: LanguageType) {
        // Stop any ongoing speech
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
        }

        // Create utterance with appropriate language code
        let utterance = AVSpeechUtterance(string: word)
        utterance.voice = AVSpeechSynthesisVoice(language: language.rawValue)
        utterance.rate = 0.5
        utterance.pitchMultiplier = 1.0
        utterance.volume = 1.0

        // Speak
        synthesizer.speak(utterance)
    }

    func processSwipe(card: FlashcardEntity, direction: SwipeDirection) {
        // Remove the card from current deck
        if let index = currentCards.firstIndex(where: { $0.id == card.id }) {
            currentCards.remove(at: index)
        }

        switch direction {
        case .right:  // Learned
            // Add to remembered cards
            rememberedCards.append(card)
            // Remove from cards to learn
            card.isStudied = true
            if let index = cardsToLearn.firstIndex(where: { $0.id == card.id }) {
                cardsToLearn.remove(at: index)
            }
            // Update progress
            updateProgress()

        case .left:  // Need to learn again
            // For left swipe, we just need to make sure it stays in cardsToLearn
            // The card is already removed from currentCards above
            // We don't need to add it back to currentCards - it will be included in the next round
            card.isStudied = false
            // Make sure it's in cardsToLearn (in case it was somehow not there)
            if !cardsToLearn.contains(where: { $0.id == card.id }) {
                cardsToLearn.append(card)
            }
        }

        // Check if current round is complete
        if currentCards.isEmpty {
            if cardsToLearn.isEmpty {
                // All cards learned
                allCardsLearned = true
            } else {
                // Round complete, but still cards to learn
                isRoundComplete = true
            }
        }
    }

    func startNewRound() {
            currentCards = cardsToLearn
            isRoundComplete = false
        }
        
        // Reset all cards
        func resetAllCards() {
            rememberedCards = []
            cardsToLearn = []
            currentCards = allCards
            isRoundComplete = false
            allCardsLearned = false
            updateProgress()
        }
        
        // Calculate progress based on remembered cards
        func updateProgress() {
            if allCards.count > 0 {
                progress = Double(rememberedCards.count) / Double(allCards.count)
            } else {
                progress = 0.0
            }
        }
}

enum SwipeDirection {
    case left
    case right
}
