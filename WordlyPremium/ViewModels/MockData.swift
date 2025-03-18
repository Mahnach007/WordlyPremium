//
//  MockData.swift
//  WordlyPremium
//
//  Created by Diego Arroyo on 17/03/25.
//


struct MockData {
    static func getMockPacks() -> [PackEntity] {
        return [
            PackEntity(name: "Spanish Pack", isAIGenerated: false, flashcards: [
                FlashcardEntity(question: "Hello", answer: "Hola", isStudied: true),
                FlashcardEntity(question: "Goodbye", answer: "Adiós", isStudied: false),
                FlashcardEntity(question: "Please", answer: "Por favor", isStudied: true),
                FlashcardEntity(question: "Thank you", answer: "Gracias", isStudied: true),
                FlashcardEntity(question: "Yes", answer: "Sí", isStudied: false),
                FlashcardEntity(question: "No", answer: "No", isStudied: false),
                FlashcardEntity(question: "Excuse me", answer: "Perdón", isStudied: true),
                FlashcardEntity(question: "Sorry", answer: "Lo siento", isStudied: true)
            ]),
            PackEntity(name: "French Pack", isAIGenerated: true, flashcards: [
                FlashcardEntity(question: "Hello", answer: "Bonjour", isStudied: false),
                FlashcardEntity(question: "Goodbye", answer: "Au revoir", isStudied: true),
                FlashcardEntity(question: "Please", answer: "S'il vous plaît", isStudied: false),
                FlashcardEntity(question: "Thank you", answer: "Merci", isStudied: true),
                FlashcardEntity(question: "Yes", answer: "Oui", isStudied: false),
                FlashcardEntity(question: "No", answer: "Non", isStudied: true),
                FlashcardEntity(question: "Excuse me", answer: "Excusez-moi", isStudied: true),
                FlashcardEntity(question: "Sorry", answer: "Désolé", isStudied: true)
            ]),
            PackEntity(name: "German Pack", isAIGenerated: false, flashcards: [
                FlashcardEntity(question: "Hello", answer: "Hallo", isStudied: true),
                FlashcardEntity(question: "Goodbye", answer: "Auf Wiedersehen", isStudied: false),
                FlashcardEntity(question: "Please", answer: "Bitte", isStudied: true),
                FlashcardEntity(question: "Thank you", answer: "Danke", isStudied: true),
                FlashcardEntity(question: "Yes", answer: "Ja", isStudied: false),
                FlashcardEntity(question: "No", answer: "Nein", isStudied: false),
                FlashcardEntity(question: "Excuse me", answer: "Entschuldigung", isStudied: true),
                FlashcardEntity(question: "Sorry", answer: "Es tut mir leid", isStudied: true)
            ]),
            PackEntity(name: "Italian Pack", isAIGenerated: true, flashcards: [
                FlashcardEntity(question: "Hello", answer: "Ciao", isStudied: true),
                FlashcardEntity(question: "Goodbye", answer: "Arrivederci", isStudied: true),
                FlashcardEntity(question: "Please", answer: "Per favore", isStudied: false),
                FlashcardEntity(question: "Thank you", answer: "Grazie", isStudied: true),
                FlashcardEntity(question: "Yes", answer: "Sì", isStudied: false),
                FlashcardEntity(question: "No", answer: "No", isStudied: false),
                FlashcardEntity(question: "Excuse me", answer: "Mi scusi", isStudied: true),
                FlashcardEntity(question: "Sorry", answer: "Scusa", isStudied: true)
            ]),
            PackEntity(name: "Japanese Pack", isAIGenerated: false, flashcards: [
                FlashcardEntity(question: "Hello", answer: "こんにちは (Konnichiwa)", isStudied: true),
                FlashcardEntity(question: "Goodbye", answer: "さようなら (Sayōnara)", isStudied: false),
                FlashcardEntity(question: "Please", answer: "お願いします (Onegaishimasu)", isStudied: false),
                FlashcardEntity(question: "Thank you", answer: "ありがとうございます (Arigatou gozaimasu)", isStudied: true),
                FlashcardEntity(question: "Yes", answer: "はい (Hai)", isStudied: false),
                FlashcardEntity(question: "No", answer: "いいえ (Iie)", isStudied: true),
                FlashcardEntity(question: "Excuse me", answer: "すみません (Sumimasen)", isStudied: true),
                FlashcardEntity(question: "Sorry", answer: "ごめんなさい (Gomen nasai)", isStudied: true)
            ]),
            PackEntity(name: "Russian Pack", isAIGenerated: true, flashcards: [
                FlashcardEntity(question: "Hello", answer: "Здравствуйте (Zdravstvuyte)", isStudied: true),
                FlashcardEntity(question: "Goodbye", answer: "До свидания (Do svidaniya)", isStudied: false),
                FlashcardEntity(question: "Please", answer: "Пожалуйста (Pozhaluysta)", isStudied: true),
                FlashcardEntity(question: "Thank you", answer: "Спасибо (Spasibo)", isStudied: true),
                FlashcardEntity(question: "Yes", answer: "Да (Da)", isStudied: false),
                FlashcardEntity(question: "No", answer: "Нет (Net)", isStudied: false),
                FlashcardEntity(question: "Excuse me", answer: "Извините (Izvinite)", isStudied: true),
                FlashcardEntity(question: "Sorry", answer: "Извините (Izvinite)", isStudied: false)
            ])
        ]
    }
}
