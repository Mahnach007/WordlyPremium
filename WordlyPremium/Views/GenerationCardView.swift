//
//  GenerationCardView.swift
//  WordlyPremium
//
//  Created by Diego Arroyo on 11/03/25.
//

import SwiftData
import SwiftUI

struct GenerationCardView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.dataService) private var dataService
    @Binding var flashcards: [Flashcard]

    var isAIGenerated: Bool
    var titlePlaceholder: String
    var onSave: () -> Void
    var selectedFolder: FolderEntity?
    var onAddFlashcard: () -> Void

    @State private var title = ""
    @FocusState private var isFocused: Bool
    @State private var showAlert = false
    @State private var alertMessage = ""

    private var canSave: Bool {
        return !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !flashcards.isEmpty
    }

    private func savePack() {
        guard let folder = selectedFolder else {
            alertMessage = "Please select a folder to save to"
            showAlert = true
            return
        }

        if canSave {
            dataService.saveGeneratedPack(
                title: title,
                flashcards: flashcards,
                isAIGenerated: isAIGenerated,
                inFolder: folder
            )

            onSave()

            dismiss()
        }
    }

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
                            answer: $flashcard.answer,
                            isAIGenerated: isAIGenerated
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

                    Button(action: {
                        if canSave {
                            savePack()
                        }
                    }) {
                        HStack {
                            Text(Image(systemName: "checkmark"))
                                .fontWeight(.bold)
                                .foregroundStyle(canSave ? Color.aqua : Color.gray)
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
        }
        .background(Color.background)
    }
}

struct DataServiceKey: EnvironmentKey {
    static let defaultValue = DataService()
}

extension EnvironmentValues {
    var dataService: DataService {
        get { self[DataServiceKey.self] }
        set { self[DataServiceKey.self] = newValue }
    }
}

#Preview {
    GenerationCardView(
        flashcards: .constant([Flashcard(question: "Example", answer: "Answer")]),
        isAIGenerated: false,
        titlePlaceholder: "New Pack",
        onSave: {},
        selectedFolder: nil,
        onAddFlashcard: {}
    )
}
