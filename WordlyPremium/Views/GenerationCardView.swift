//
//  GenerationCardView.swift
//  WordlyPremium
//
//  Created by Diego Arroyo on 11/03/25.
//

import SwiftUI

struct GenerationCardView: View {
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @FocusState private var isFocused: Bool
    @State private var flashcards: [Flashcard] = []

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 20) {
                VStack(alignment: .leading) {
                    Text("Title*")
                    TextArea(
                        inputText: $title, isMultiline: false,
                        placeholder: "Enter the title of the pack..."
                    )
                    .focused($isFocused)
                }
                ScrollView(.vertical) {
                    ForEach($flashcards) { $flashcard in
                        AddNewCard(
                            question: $flashcard.question,
                            answer: $flashcard.answer)
                    }
                }

                AddButton(isRounded: true)
                    .onTapGesture {
                        let newCard = Flashcard(question: "", answer: "")
                        flashcards.append(newCard)
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
                    Button(action: {
                        dismiss()
                    }) {
                        HStack {
                            Text(Image(systemName: "arrow.left"))
                                .fontWeight(.bold)
                                .foregroundStyle(Color.eel)
                        }
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("Manual Card Generation")
                        .foregroundStyle(Color.eel)
                        .font(.custom("Feather", size: 16))
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        saveFlashcards()
                    }) {
                        HStack {
                            Text(Image(systemName: "checkmark"))
                                .fontWeight(.bold)
                                .foregroundStyle(Color.aqua)
                        }
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .regainSwipeBack()
        }
        .background(Color.background)
    }

    private func saveFlashcards() {
        for flashcard in flashcards {
            print(
                "Question: \(flashcard.question), Answer: \(flashcard.answer)"
            )
        }
    }
}

#Preview {
    GenerationCardView()
}
