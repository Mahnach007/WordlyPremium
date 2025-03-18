//
//  DestinationType.swift
//  WordlyPremium
//
//  Created by Diego Arroyo on 07/03/25.
//
import SwiftUI

// Parameter types
enum DestinationType: Hashable {
    case firstOption
    case secondOption(isAIGenerated: Bool)
    case thirdOption
    
    @ViewBuilder
    var view: some View {
        switch self {
        case .firstOption:
            AIGenerationCardView()
        case .secondOption:
            GenerationCardView(
                flashcards: .constant([FlashcardEntity(question: "Example", answer: "Answer")]),
                isAIGenerated: false,
                titlePlaceholder: "New Pack",
                onAddFlashcard: {}
            )
        case .thirdOption:
            CreateFolderView()
        }
    }
}

enum SelectionType {
    case cardType
    case languageType
}

enum CardType: String, CaseIterable, Codable {
    case singleWord = "single word"
    case phrase = "phrase"
    case sentence = "sentence"
    case mixed = "mixed"
}

enum LanguageType: String, Hashable {
    case english = "english"
    case ukrainian = "ukrainian"
    case italian = "italian"
    
    var identifier: String {
        switch self {
        case .english:
            return "en-US"
        case .italian:
            return "it-IT"
        case .ukrainian:
            return "uk"
        }
    }
}

enum WordType: String, CaseIterable, Codable {
    case noun = "noun"
    case verb = "verb"
    case adjective = "adjective"
    case adverb = "adverb"
}

enum NavigationDestination: Hashable {
    case generationCardView
}
