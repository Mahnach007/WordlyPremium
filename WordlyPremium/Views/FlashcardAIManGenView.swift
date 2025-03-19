//
//  FlashcardAIManGenView.swift
//  WordlyPremium
//
//  Created by Diego Arroyo on 11/03/25.
//

import SwiftData
import SwiftUI

struct FlashcardAIManGenView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var flashcards: [FlashcardEntity]

    var isAIGenerated: Bool
    var titlePlaceholder: String
    var langFrom: LanguageType
    var langTo: LanguageType
    var onAddFlashcard: () -> Void

    @State private var title = ""
    @FocusState private var isFocused: Bool
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var showSaveConfirmation = false

    private var canSave: Bool {
        return !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            && !flashcards.isEmpty
    }

    var dataService = DataService()

    private func savePack() {
        /// Validate title and cards
        guard !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        else {
            alertMessage = "Please enter a title for the pack"
            showAlert = true
            return
        }

        guard !flashcards.isEmpty else {
            alertMessage = "Please add at least one card"
            showAlert = true
            return
        }

        /// Create a Pack (but don't save to a folder yet)
        let pack = PackEntity(
            name: title,
            isAIGenerated: isAIGenerated,
            langFrom: langFrom,
            langTo: langTo,
            flashcards: flashcards
        )

        dataService.createPack(
            name: title, isAIGenerated: isAIGenerated, langFrom: langFrom, langTo: langTo, flashcards: flashcards)

        /// Show success message
        showSaveConfirmation = true

        /// Print confirmation for debugging
        print(
            "\(isAIGenerated ? "AI-generated" : "Manual") pack created: \(title) with \(flashcards.count) cards"
        )

        /// Dismiss after a short delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            dismiss()
        }
    }

    /// Function to add a new flashcard to the collection
    private func addNewFlashcard() {
        withAnimation {
            print(flashcards)
            flashcards.append(FlashcardEntity(question: "", answer: "", isStudied: false))
            print(flashcards)
            print("New flashcard added. Total: \(flashcards.count)")
        }
        onAddFlashcard()
    }

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 20) {
                VStack(alignment: .leading) {
                    Text("Title*")
                    TextArea(
                        inputText: $title,
                        isMultiline: false,
                        placeholder: titlePlaceholder
                    )
                    .focused($isFocused)
                }
                ScrollView(.vertical) {
                    VStack(spacing: 10) {
                        ForEach($flashcards) { $flashcard in
                            AddNewCard(
                                question: $flashcard.question,
                                answer: $flashcard.answer,
                                isAIGenerated: isAIGenerated
                            )
                        }
                    }
                }
                AddButton(isRounded: true)
                    .onTapGesture {
                        addNewFlashcard()
                    }
            }
            .font(.custom("Feather", size: 12))
            .frame(maxHeight: .infinity, alignment: .top)
            .padding()
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        isFocused = false
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: { dismiss() }) {
                        HStack {
                            Text(Image(systemName: "arrow.left"))
                                .fontWeight(.bold)
                                .foregroundStyle(Color.eel)
                        }
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text(titlePlaceholder)
                        .foregroundStyle(Color.eel)
                        .font(.custom("Feather", size: 16))
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    if isAIGenerated {
                        Button(action: {
                            dismiss()
                        }) {
                            Image("regenerate2")
                        }
                    }

                    Button(action: {
                        if canSave {
                            savePack()
                        }
                    }) {
                        HStack {
                            Text(Image(systemName: "checkmark"))
                                .fontWeight(.bold)
                                .foregroundStyle(
                                    canSave ? Color.aqua : Color.gray)
                        }
                    }
                    .disabled(!canSave)
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .regainSwipeBack()
            .alert("Save Error", isPresented: $showAlert) {
                Button("OK") {
                    showAlert = false
                }
            } message: {
                Text(alertMessage)
            }
            .overlay {
                // Success message overlay
                if showSaveConfirmation {
                    VStack {
                        Text("Pack Created Successfully!")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green.opacity(0.8))
                            .cornerRadius(10)
                            .shadow(radius: 3)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.3))
                    .edgesIgnoringSafeArea(.all)
                    .transition(.opacity)
                }
            }
        }
        .background(Color.background)
        .onAppear {
            if isAIGenerated {
                title = titlePlaceholder
            }
        }
    }
}

#Preview {
    @Previewable @State var flashcards: [FlashcardEntity] = [
        FlashcardEntity(question: "Example", answer: "Answer", isStudied: false)
    ]
    FlashcardAIManGenView(
        flashcards: $flashcards,
        isAIGenerated: true,
        titlePlaceholder: "New Pack",
        langFrom: LanguageType.english,
        langTo: LanguageType.italian,
        onAddFlashcard: {}
    )
}
