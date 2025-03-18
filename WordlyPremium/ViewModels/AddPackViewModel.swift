//
//  AddPackViewModel.swift
//  WordlyPremium
//
//  Created by Diego Arroyo on 18/03/25.
//

import Foundation

class AddPackViewModel: ObservableObject {

    private var dataService: DataService = DataService()
    @Published var packs: [PackEntity] = [
        PackEntity(
            name: "Spanish Pack", isAIGenerated: false,
            flashcards: [
                FlashcardEntity(
                    question: "Hello", answer: "Hola", isStudied: true),
                FlashcardEntity(
                    question: "Goodbye", answer: "Adiós", isStudied: false),
                FlashcardEntity(
                    question: "Please", answer: "Por favor", isStudied: true),
                FlashcardEntity(
                    question: "Thank you", answer: "Gracias", isStudied: true),
                FlashcardEntity(
                    question: "Yes", answer: "Sí", isStudied: false),
                FlashcardEntity(question: "No", answer: "No", isStudied: false),
                FlashcardEntity(
                    question: "Excuse me", answer: "Perdón", isStudied: true),
                FlashcardEntity(
                    question: "Sorry", answer: "Lo siento", isStudied: true),
            ])
    ]

    init() {
        // Load folders initially
        refreshPacks()
    }

    func fetchAllPacks() -> [PackEntity] {
        dataService.fetchAllPacks()
    }

    func refreshPacks() {
        packs = fetchAllPacks()  // Update the published property
    }
}
