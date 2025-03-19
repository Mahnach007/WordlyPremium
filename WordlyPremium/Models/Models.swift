//
//  Models.swift
//  WordlyPremium
//
//  Created by Jahongir Abdujalilov on 06/03/25.
//

import Foundation

struct Folder: Codable, Identifiable {
    let id: UUID = UUID()
    let name: String
    var packs: [Pack]

    enum CodingKeys: String, CodingKey {
        case name, packs
    }
}

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

    var studiedFlashcardsCount: Int {
        return flashcards.filter { $0.isStudied }.count
    }

    var notStudiedFlashcardsCount: Int {
        return flashcards.filter { !$0.isStudied }.count
    }

    enum CodingKeys: String, CodingKey {
        case name, isAIGenerated, flashcards
    }
}

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

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        question = try container.decode(String.self, forKey: .question)
        answer = try container.decode(String.self, forKey: .answer)
        isStudied =
            try container.decodeIfPresent(Bool.self, forKey: .isStudied)
            ?? false
    }
}

struct GenerateCardsRequest: Codable {
    var fromLanguage: String? = nil
    var toLanguage: String? = nil
    var topic: String? = nil
    var cardType: String? = nil
    var numCards: String? = nil
    var wordTypes: Set<String>
}

struct APIFlashcard: Codable {
    var question: String
    var answer: String

    enum CodingKeys: String, CodingKey {
        case question = "langFrom"
        case answer = "langTo"
    }
}

struct FlashcardResponse: Codable {
    let packName: String
    let flashCards: [APIFlashcard]
}

struct APIFlashcardResponse: Codable {
    let packName: String
    let flashCards: [APIFlashcard]
}

extension FlashcardService {
    func convertToFlashcards(_ apiFlashcards: [APIFlashcard]) -> [Flashcard] {
        return apiFlashcards.map {
            Flashcard(
                question: $0.question,
                answer: $0.answer,
                isStudied: false
            )
        }
    }
}
