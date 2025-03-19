//
//  DataService.swift
//  WordlyPremium
//
//  Created by Jahongir Abdujalilov on 18/03/25.
//

import Foundation
import SwiftData
import SwiftUI

class DataService: ObservableObject {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext

    // MARK: - Initialization

    init() {
        do {
            let schema = Schema([
                FolderEntity.self, PackEntity.self, FlashcardEntity.self,
                AppConfiguration.self,
            ])
            let configuration = ModelConfiguration(
                schema: schema, isStoredInMemoryOnly: false)
            self.modelContainer = try ModelContainer(
                for: schema, configurations: [configuration])
            self.modelContext = ModelContext(modelContainer)
        } catch {
            fatalError(
                "Failed to create model container: \(error.localizedDescription)"
            )
        }
    }

    // MARK: - Folder Operations

    func fetchAllFolders() -> [FolderEntity] {
        let descriptor = FetchDescriptor<FolderEntity>()
        do {
            return try modelContext.fetch(descriptor)
        } catch {
            print("Failed to fetch folders: \(error)")
            return []
        }
    }

    func createFolder(name: String) -> FolderEntity {
        let folder = FolderEntity(name: name)
        modelContext.insert(folder)
        saveContext()
        return folder
    }

    func updateFolder(folder: FolderEntity, newName: String) {
        folder.name = newName
        saveContext()
    }

    func deleteFolder(_ folder: FolderEntity) {
        modelContext.delete(folder)
        saveContext()
    }

    // MARK: - Pack Operations

    func fetchAllPacks() -> [PackEntity] {
        let descriptor = FetchDescriptor<PackEntity>()
        do {
            return try modelContext.fetch(descriptor)
        } catch {
            print("Failed to fetch packs: \(error)")
            return []
        }
    }

    func createPack(
        name: String, isAIGenerated: Bool, langFrom: LanguageType, langTo: LanguageType,
        flashcards: [FlashcardEntity] = []
    ) -> PackEntity {
        let pack = PackEntity(
            name: name, isAIGenerated: isAIGenerated, langFrom: langFrom, langTo: langTo,
            flashcards: flashcards)
        modelContext.insert(pack)
        saveContext()
        return pack
    }

    // Direct creation method for GenerationCardView
    func saveGeneratedPack(
        title: String, flashcards: [FlashcardEntity], isAIGenerated: Bool, langFrom: LanguageType, langTo: LanguageType, inFolder: FolderEntity
    ) -> PackEntity {
        let pack = PackEntity(
            name: title, isAIGenerated: isAIGenerated,
            langFrom: langFrom,
            langTo: langTo,
            flashcards: flashcards)
        inFolder.packs.append(pack)
        modelContext.insert(pack)
        saveContext()
        return pack
    }

    func updatePack(_ pack: PackEntity, newName: String) {
        pack.name = newName
        saveContext()
    }

    func deletePack(_ pack: PackEntity) {
        modelContext.delete(pack)
        saveContext()
    }

    // MARK: - Flashcard Operations

    func addFlashcard(question: String, answer: String, toPack pack: PackEntity, isStudied: Bool = false) -> FlashcardEntity
    {
        let flashcard = FlashcardEntity(question: question, answer: answer, isStudied: isStudied)
        pack.flashcards.append(flashcard)
        modelContext.insert(flashcard)
        saveContext()
        return flashcard
    }

    func updateFlashcard(_ flashcard: FlashcardEntity, newQuestion: String, newAnswer: String) {
        flashcard.question = newQuestion
        flashcard.answer = newAnswer
        saveContext()
    }

    func toggleStudiedStatus(_ flashcard: FlashcardEntity) {
        flashcard.isStudied = !flashcard.isStudied
        saveContext()
    }

    func deleteFlashcard(_ flashcard: FlashcardEntity) {
        modelContext.delete(flashcard)
        saveContext()
    }

    // MARK: - Utility Functions

    func saveContext() {
        do {
            try modelContext.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
}
