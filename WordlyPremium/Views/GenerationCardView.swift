//
//  GenerationCardView.swift
//  WordlyPremium
//
//  Created by Diego Arroyo on 11/03/25.
//

import SwiftUI

struct GenerationCardView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var flashcards: [Flashcard]
    
    var titlePlaceholder: String
    var onSave: () -> Void
    var onAddFlashcard: () -> Void

    @State private var title = ""
    @State var isAIGenerated: Bool
    @FocusState private var isFocused: Bool

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 20) {
                VStack(alignment: .leading) {
                    Text("Title*")
                    TextArea(
                        inputText: $title, isMultiline: false,
                        placeholder: titlePlaceholder
                    )
                    .focused($isFocused)
                }
                ScrollView(.vertical) {
                    ForEach($flashcards) { $flashcard in
                        AddNewCard(
                            question: $flashcard.question,
                            answer: $flashcard.answer
                        )
                    }
                }
                AddButton(isRounded: true)
                    .onTapGesture {
                        onAddFlashcard()
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

                    Button(action: { onSave() }) {
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
}

#Preview {
    GenerationCardView(isAIGenerated: false)
}
