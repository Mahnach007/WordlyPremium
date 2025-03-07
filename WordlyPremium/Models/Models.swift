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
    
    enum CodingKeys: String, CodingKey {
        case name, isAIGenerated, flashcards
    }
}

// Request Model
struct GenerateCardsRequest: Codable {
    let fromLanguage: String
    let toLanguage: String
    let topic: String
    let numCards: Int
    let wordType: String
    let options: Options?

    struct Options: Codable {
        let difficulty: String?
        let context: String?
    }
}

// Response Model
struct FlashcardResponse: Codable {
    let packName: String
    let flashCards: [Flashcard]
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

// Enum for Card Amount Selection
enum CardAmount: String, CaseIterable, Codable {
    case five = "5"
    case ten = "10"
    case twenty = "20"
    case automatic = "Automatic"
}
