//
//  Models.swift
//  WordlyPremium
//
//  Created by Jahongir Abdujalilov on 06/03/25.
//

import Foundation

// Flashcard Request Model
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
    func convertToFlashcards(_ apiFlashcards: [APIFlashcard]) -> [FlashcardEntity] {
        return apiFlashcards.map {
            FlashcardEntity(
                question: $0.question,
                answer: $0.answer,
                isStudied: false
            )
        }
    }
}
