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
                FolderEntity.self, PackEntity.self, FlashcardEntity.self, AppConfiguration.self,
            ])
            let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            self.modelContainer = try ModelContainer(for: schema, configurations: [configuration])
            self.modelContext = ModelContext(modelContainer)
        } catch {
            fatalError("Failed to create model container: \(error.localizedDescription)")
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
        name: String, isAIGenerated: Bool, flashcards: [FlashcardEntity] = []
//        inFolder: FolderEntity
    ) -> PackEntity {
        let pack = PackEntity(name: name, isAIGenerated: isAIGenerated, flashcards: flashcards)
//        inFolder.packs.append(pack)
        modelContext.insert(pack)
        saveContext()
        return pack
    }

    // Create a pack from struct models
    func createPack(fromStructPack pack: Pack, inFolder: FolderEntity) -> PackEntity {
        let packEntity = PackEntity.from(pack: pack)
        inFolder.packs.append(packEntity)
        modelContext.insert(packEntity)
        saveContext()
        return packEntity
    }

    // Direct creation method for GenerationCardView
    func saveGeneratedPack(
        title: String, flashcards: [Flashcard], isAIGenerated: Bool, inFolder: FolderEntity
    ) -> PackEntity {
        let flashcardEntities = flashcards.map { FlashcardEntity.from(flashcard: $0) }
        let pack = PackEntity(
            name: title, isAIGenerated: isAIGenerated, flashcards: flashcardEntities)
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

    func addFlashcard(question: String, answer: String, toPack pack: PackEntity) -> FlashcardEntity
    {
        let flashcard = FlashcardEntity(question: question, answer: answer)
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

    // MARK: - Search and Filter

//    func searchPacks(byName searchTerm: String) -> [PackEntity] {
//        let predicate = #Predicate<PackEntity> { pack in
//            pack.name.localizedStandardContains(searchTerm)
//        }
//
//        var descriptor = FetchDescriptor<PackEntity>(predicate: predicate)
//        descriptor.sortBy = [SortDescriptor(\.name)]
//
//        do {
//            return try modelContext.fetch(descriptor)
//        } catch {
//            print("Failed to search packs: \(error)")
//            return []
//        }
//    }

//    func fetchPacksWithStudyProgress(minProgress: Double = 0, maxProgress: Double = 1.0)
//        -> [PackEntity]
//    {
//        let predicate = #Predicate<PackEntity> { pack in
//            let progress = pack.studiedPercentage
//            return progress >= minProgress && progress <= maxProgress
//        }
//
//        var descriptor = FetchDescriptor<PackEntity>(predicate: predicate)
//        descriptor.sortBy = [SortDescriptor(\.name)]
//
//        do {
//            return try modelContext.fetch(descriptor)
//        } catch {
//            print("Failed to fetch packs by progress: \(error)")
//            return []
//        }
//    }

    // MARK: - App Configuration

//    func getOrCreateAppConfiguration() -> AppConfiguration {
//        let descriptor = FetchDescriptor<AppConfiguration>()
//        do {
//            let configurations = try modelContext.fetch(descriptor)
//            if let existingConfig = configurations.first {
//                return existingConfig
//            } else {
//                let newConfig = AppConfiguration()
//                modelContext.insert(newConfig)
//                saveContext()
//                return newConfig
//            }
//        } catch {
//            print("Failed to fetch app configuration: \(error)")
//            let newConfig = AppConfiguration()
//            modelContext.insert(newConfig)
//            saveContext()
//            return newConfig
//        }
//    }

//    func updateAppConfiguration(
//        selectedLanguages: [String]? = nil, selectedCardAmount: String? = nil
//    ) {
//        let config = getOrCreateAppConfiguration()
//
//        if let languages = selectedLanguages {
//            config.selectedLanguages = languages
//        }
//
//        if let cardAmount = selectedCardAmount {
//            config.selectedCardAmount = cardAmount
//        }
//
//        saveContext()
//    }

    // MARK: - Utility Functions

    func saveContext() {
        do {
            try modelContext.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
}
