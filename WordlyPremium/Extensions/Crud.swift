//
//  Crud.swift
//  WordlyPremium
//
//  Created by Jahongir Abdujalilov on 07/03/25.
//

extension Folder {
    mutating func addPack(_ pack: Pack) {
        packs.append(pack)
    }
    
    mutating func editPack(at index: Int, with pack: Pack) {
        guard index < packs.count else { return }
        packs[index] = pack
    }
    
    mutating func deletePack(at index: Int) {
        guard index < packs.count else { return }
        packs.remove(at: index)
    }
}

extension Pack {
    mutating func addFlashcard(_ flashcard: Flashcard) {
        flashcards.append(flashcard)
    }
    
    mutating func editFlashcard(at index: Int, with flashcard: Flashcard) {
        guard index < flashcards.count else { return }
        flashcards[index] = flashcard
    }
    
    mutating func deleteFlashcard(at index: Int) {
        guard index < flashcards.count else { return }
        flashcards.remove(at: index)
    }
}

extension Flashcard {
    /// Returns a formatted string for the flashcard (e.g., "Question: Hello | Answer: Hola").
    var formattedDescription: String {
        return "Question: \(question) | Answer: \(answer)"
    }
    
    /// Returns true if the flashcard is empty (both question and answer are empty).
    var isEmpty: Bool {
        return question.isEmpty && answer.isEmpty
    }
    
    // MARK: - Methods
    
    /// Creates a new flashcard with swapped question and answer.
    func swapped() -> Flashcard {
        return Flashcard(question: answer, answer: question)
    }
    
    /// Checks if the flashcard matches a given search term (case-insensitive).
    func matches(searchTerm: String) -> Bool {
        return question.localizedCaseInsensitiveContains(searchTerm) ||
               answer.localizedCaseInsensitiveContains(searchTerm)
    }
    
    /// Updates the flashcard with new question and answer values.
    mutating func update(question: String, answer: String) {
        self.question = question
        self.answer = answer
    }
}
