//
//  DataModels.swift
//  WordlyPremium
//
//  Created by Jahongir Abdujalilov on 18/03/25.
//

import Foundation
import SwiftData
import SwiftUI

@Model
final class FolderEntity {
    var name: String
    @Relationship(deleteRule: .cascade) var packs: [PackEntity]
    
    init(name: String, packs: [PackEntity] = []) {
        self.name = name
        self.packs = packs
    }
    
    /// Conversion from struct to entity
//    static func from(folder: Folder) -> FolderEntity {
//        let folderEntity = FolderEntity(name: folder.name)
//        folderEntity.packs = folder.packs.map { PackEntity.from(pack: $0) }
//        return folderEntity
//    }
    
    /// Conversion from entity to struct
//    func toFolder() -> Folder {
//        return Folder(
//            name: self.name,
//            packs: self.packs.map { $0.toPack() }
//        )
//    }
    
    // Conversion from struct to entity
    //    static func from(folder: Folder) -> FolderEntity {
    //        let folderEntity = FolderEntity(name: folder.name)
    //        folderEntity.packs = folder.packs.map { PackEntity.from(pack: $0) }
    //        return folderEntity
    //    }
    
    // Conversion from entity to struct
    //    func toFolder() -> Folder {
    //        return Folder(
    //            name: self.name,
    //            packs: self.packs.map { $0.toPack() }
    //        )
    //    }
}

@Model
final class PackEntity {
    var name: String
    var isAIGenerated: Bool
    var langFrom: LanguageType
    var langTo: LanguageType
    @Relationship(deleteRule: .cascade) var flashcards: [FlashcardEntity]
    
    init(name: String, isAIGenerated: Bool, langFrom: LanguageType, langTo: LanguageType, flashcards: [FlashcardEntity]) {
        self.name = name
        self.isAIGenerated = isAIGenerated
        self.langFrom = langFrom
        self.langTo = langTo
        self.flashcards = flashcards
    }
        
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
            return flashcards.filter { !$0.isStudied
            }.count
        }
        
        /// Conversion from struct to entity
        //    static func from(pack: Pack) -> PackEntity {
        //        let packEntity = PackEntity(
        //            name: pack.name,
        //            isAIGenerated: pack.isAIGenerated
        //        )
        //        packEntity.flashcards = pack.flashcards.map {
        //            FlashcardEntity.from(flashcard: $0)
        //        }
        //        return packEntity
        //    }
        
        /// Conversion from entity to struct
        //    func toPack() -> Pack {
        //        return Pack(
        //            name: self.name,
        //            isAIGenerated: self.isAIGenerated,
        //            flashcards: self.flashcards.map { $0.toFlashcard() }
        //        )
        //    }
        
        // Conversion from struct to entity
        //    static func from(pack: Pack) -> PackEntity {
        //        let packEntity = PackEntity(
        //            name: pack.name,
        //            isAIGenerated: pack.isAIGenerated
        //        )
        //        packEntity.flashcards = pack.flashcards.map { FlashcardEntity.from(flashcard: $0) }
        //        return packEntity
        //    }
        
        // Conversion from entity to struct
        //    func toPack() -> Pack {
        //        return Pack(
        //            name: self.name,
        //            isAIGenerated: self.isAIGenerated,
        //            flashcards: self.flashcards.map { $0.toFlashcard() }
        //        )
        //    }
//    }
}

@Model
final class FlashcardEntity {
    var question: String
    var answer: String
    var isStudied: Bool
    
    init(question: String, answer: String, isStudied: Bool) {
        self.question = question
        self.answer = answer
        self.isStudied = isStudied
    }
    
    
    /// Conversion from struct to entity
    //    static func from(flashcard: Flashcard) -> FlashcardEntity {
    //        return FlashcardEntity(
    //            question: flashcard.question,
    //            answer: flashcard.answer,
    //            isStudied: flashcard.isStudied
    //        )
    //    }
    
    /// Conversion from entity to struct
    //    func toFlashcard() -> Flashcard {
    //        return Flashcard(
    //            question: self.question,
    //            answer: self.answer,
    //            isStudied: self.isStudied
    //        )
    //    }
    
    // Conversion from struct to entity
    //    static func from(flashcard: Flashcard) -> FlashcardEntity {
    //        return FlashcardEntity(
    //            question: flashcard.question,
    //            answer: flashcard.answer,
    //            isStudied: flashcard.isStudied
    //        )
    //    }
    
    // Conversion from entity to struct
    //    func toFlashcard() -> Flashcard {
    //        return Flashcard(
    //            question: self.question,
    //            answer: self.answer,
    //            isStudied: self.isStudied
    //        )
    //    }
}

/// Additional model for app configuration if needed
@Model
final class AppConfiguration {
    var selectedLanguages: [String]
    var selectedCardAmount: String
    
    init(selectedLanguages: [String] = [], selectedCardAmount: String = "10") {
        self.selectedLanguages = selectedLanguages
        self.selectedCardAmount = selectedCardAmount
    }
}
