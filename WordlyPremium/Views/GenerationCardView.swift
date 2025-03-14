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
    @State var isAIGenerated: Bool
    @FocusState private var isFocused: Bool
    @State private var flashcards: [Flashcard] = []

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 20) {
                VStack(alignment: .leading) {
                    Text("Title*")
                    TextArea(
                        inputText: $title, isMultiline: false,
                        placeholder: "Enter card pack title..."
                    )
                    .focused($isFocused)
                }
                ScrollView(.vertical) {
                    ForEach($flashcards) { $flashcard in
                        AddNewCard(
                            question: $flashcard.question,
                            answer: $flashcard.answer,
                            isAIGenerated: isAIGenerated)
                        .padding(.bottom)
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
                    Text(isAIGenerated ? "AI Generated Cards" : "Manual Card Generation")
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
    GenerationCardView(isAIGenerated: false)
}
