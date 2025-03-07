//
//  model.swift
//  WordlyPremium
//
//  Created by Jahongir Abdujalilov on 06/03/25.
//

import Foundation

// Request Model
struct GenerateCardsRequest: Encodable {
    let fromLanguage: String
    let toLanguage: String
    let topic: String
    let numCards: Int
    let wordType: String
    let options: Options?

    struct Options: Encodable {
        let difficulty: String?
        let context: String?
    }
}

// Response Model
struct GenerateCardsResponse: Decodable {
    let cards: [Flashcard]
}

struct Flashcard: Decodable, Identifiable {
    let id = UUID()
    let question: String
    let answer: String
}
