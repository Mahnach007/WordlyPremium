//
//  MockData.swift
//  WordlyPremium
//
//  Created by Diego Arroyo on 17/03/25.
//


struct MockData {
    static func getMockPacks() -> [Pack] {
        return [
            Pack(name: "Spanish Pack", isAIGenerated: false, flashcards: [
                Flashcard(question: "Hello", answer: "Hola", isStudied: true),
                Flashcard(question: "Goodbye", answer: "Adiós", isStudied: false),
                Flashcard(question: "Please", answer: "Por favor", isStudied: true),
                Flashcard(question: "Thank you", answer: "Gracias", isStudied: true),
                Flashcard(question: "Yes", answer: "Sí", isStudied: false),
                Flashcard(question: "No", answer: "No", isStudied: false),
                Flashcard(question: "Excuse me", answer: "Perdón", isStudied: true),
                Flashcard(question: "Sorry", answer: "Lo siento", isStudied: true)
            ]),
            Pack(name: "French Pack", isAIGenerated: true, flashcards: [
                Flashcard(question: "Hello", answer: "Bonjour", isStudied: false),
                Flashcard(question: "Goodbye", answer: "Au revoir", isStudied: true),
                Flashcard(question: "Please", answer: "S'il vous plaît", isStudied: false),
                Flashcard(question: "Thank you", answer: "Merci", isStudied: true),
                Flashcard(question: "Yes", answer: "Oui", isStudied: false),
                Flashcard(question: "No", answer: "Non", isStudied: true),
                Flashcard(question: "Excuse me", answer: "Excusez-moi", isStudied: true),
                Flashcard(question: "Sorry", answer: "Désolé", isStudied: true)
            ]),
            Pack(name: "German Pack", isAIGenerated: false, flashcards: [
                Flashcard(question: "Hello", answer: "Hallo", isStudied: true),
                Flashcard(question: "Goodbye", answer: "Auf Wiedersehen", isStudied: false),
                Flashcard(question: "Please", answer: "Bitte", isStudied: true),
                Flashcard(question: "Thank you", answer: "Danke", isStudied: true),
                Flashcard(question: "Yes", answer: "Ja", isStudied: false),
                Flashcard(question: "No", answer: "Nein", isStudied: false),
                Flashcard(question: "Excuse me", answer: "Entschuldigung", isStudied: true),
                Flashcard(question: "Sorry", answer: "Es tut mir leid", isStudied: true)
            ]),
            Pack(name: "Italian Pack", isAIGenerated: true, flashcards: [
                Flashcard(question: "Hello", answer: "Ciao", isStudied: true),
                Flashcard(question: "Goodbye", answer: "Arrivederci", isStudied: true),
                Flashcard(question: "Please", answer: "Per favore", isStudied: false),
                Flashcard(question: "Thank you", answer: "Grazie", isStudied: true),
                Flashcard(question: "Yes", answer: "Sì", isStudied: false),
                Flashcard(question: "No", answer: "No", isStudied: false),
                Flashcard(question: "Excuse me", answer: "Mi scusi", isStudied: true),
                Flashcard(question: "Sorry", answer: "Scusa", isStudied: true)
            ]),
            Pack(name: "Japanese Pack", isAIGenerated: false, flashcards: [
                Flashcard(question: "Hello", answer: "こんにちは (Konnichiwa)", isStudied: true),
                Flashcard(question: "Goodbye", answer: "さようなら (Sayōnara)", isStudied: false),
                Flashcard(question: "Please", answer: "お願いします (Onegaishimasu)", isStudied: false),
                Flashcard(question: "Thank you", answer: "ありがとうございます (Arigatou gozaimasu)", isStudied: true),
                Flashcard(question: "Yes", answer: "はい (Hai)", isStudied: false),
                Flashcard(question: "No", answer: "いいえ (Iie)", isStudied: true),
                Flashcard(question: "Excuse me", answer: "すみません (Sumimasen)", isStudied: true),
                Flashcard(question: "Sorry", answer: "ごめんなさい (Gomen nasai)", isStudied: true)
            ]),
            Pack(name: "Russian Pack", isAIGenerated: true, flashcards: [
                Flashcard(question: "Hello", answer: "Здравствуйте (Zdravstvuyte)", isStudied: true),
                Flashcard(question: "Goodbye", answer: "До свидания (Do svidaniya)", isStudied: false),
                Flashcard(question: "Please", answer: "Пожалуйста (Pozhaluysta)", isStudied: true),
                Flashcard(question: "Thank you", answer: "Спасибо (Spasibo)", isStudied: true),
                Flashcard(question: "Yes", answer: "Да (Da)", isStudied: false),
                Flashcard(question: "No", answer: "Нет (Net)", isStudied: false),
                Flashcard(question: "Excuse me", answer: "Извините (Izvinite)", isStudied: true),
                Flashcard(question: "Sorry", answer: "Извините (Izvinite)", isStudied: false)
            ])
        ]
    }
}
