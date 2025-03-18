//
//  model.swift
//  WordlyPremium
//
//  Created by Jahongir Abdujalilov on 06/03/25.
//

import Foundation

// Models for Components
// Folder
struct Folder: Codable, Identifiable {
    let id: UUID = UUID()
    let name: String
    var packs: [Pack]

    enum CodingKeys: String, CodingKey {
        case name, packs
    }
}

// Pack
struct Pack: Codable, Identifiable {
    let id: UUID = UUID()
    var name: String
    let isAIGenerated: Bool
    var flashcards: [Flashcard]

    var studiedPercentage: CGFloat {
        let studiedCount = flashcards.filter { $0.isStudied }.count
        let percentage = CGFloat(studiedCount) / CGFloat(flashcards.count)
        return percentage
    }

    var flashcardCount: Int {
        return flashcards.count
    }

    enum CodingKeys: String, CodingKey {
        case name, isAIGenerated, flashcards
    }
}

// Flashcard Model
struct Flashcard: Codable, Identifiable {
    let id: UUID = UUID()
    var question: String
    var answer: String

    enum CodingKeys: String, CodingKey {
        case question = "langFrom"
        case answer = "langTo"
    }
}

// Request Model
struct GenerateCardsRequest: Codable {
    var fromLanguage: String? = nil
    var toLanguage: String? = nil
    var topic: String? = nil
    var cardType: String? = nil
    var numCards: String? = nil
    var wordTypes: Set<String>
}

// Response Model
struct FlashcardResponse: Codable {
    let packName: String
    let flashCards: [Flashcard]
}

// Flashcard Model
struct Flashcard: Codable, Identifiable {
    var id: UUID = UUID()
    var question: String
    var answer: String
    var isStudied: Bool

    enum CodingKeys: String, CodingKey {
        case question = "langFrom"
        case answer = "langTo"
        case isStudied
    }

    init(
        id: UUID = UUID(), question: String, answer: String,
        isStudied: Bool = false
    ) {
        self.id = id
        self.question = question
        self.answer = answer
        self.isStudied = isStudied
    }
}

// Enum for Card Amount Selection
enum CardAmount: String, CaseIterable, Codable {
    case five = "5"
    case ten = "10"
    case twenty = "20"
    case automatic = "Automatic"
}
