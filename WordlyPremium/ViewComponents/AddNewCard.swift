import SwiftUI

struct AddNewCard: View {
    @Binding var question: String
    @Binding var answer: String
    let isAIGenerated: Bool
    var onRegenerate: (() -> Void)?

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .stroke(Color.gray, lineWidth: 1)
            VStack(alignment: .trailing) {
                UnderlineTextField(text: $question, wordType: "Question")
                UnderlineTextField(text: $answer, wordType: "Answer")
            }
            .padding(10)
            if isAIGenerated {
                HStack {
                    Spacer()
                    VStack {
                        Button(action: {
                            onRegenerate?()
                        }) {
                            Image("regenerate")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .padding(8)
                        }
                        .padding(.top, 8)
                        .padding(.trailing, 8)
                        Spacer()
                    }
                }
            }
        }
    }
}

struct CardComponent: View {
    @Binding var word: String
    @Binding var definition: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .stroke(Color.gray, lineWidth: 1)
            VStack(alignment: .trailing) {
                UnderlineTextField(text: $word, wordType: "Word")
                UnderlineTextField(text: $definition, wordType: "Definition")
            }
            .padding(10)
        }
    }
}

struct UnderlineTextField: View {
    @Binding var text: String
    var wordType: String
    @State private var suggestions: [String] = [
        "Suggestion 1", "Suggestion 2", "Suggestion 3",
    ]
    @State private var showSuggestions: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                TextField(
                    "", text: $text,
                    onEditingChanged: { isEditing in
                        withAnimation {
                            showSuggestions = isEditing
                        }
                    }
                )
                .font(.custom("feather", size: 16))
                .foregroundColor(.black)
                .underlineTextField()
            }

            HStack {
                Text(wordType)
                    .font(.custom("feather", size: 10))
                    .foregroundColor(.gray)
                Spacer()
            }

            if showSuggestions && !suggestions.isEmpty {
                CardComponentSuggestion(
                    suggestions: suggestions,
                    onSelect: { selectedSuggestion in
                        text = selectedSuggestion
                        withAnimation {
                            showSuggestions = false
                        }
                    }
                )
                .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
    }
}

struct CardComponentSuggestion: View {
    var suggestions: [String]
    var onSelect: (String) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            ForEach(suggestions, id: \.self) { suggestion in
                RoundedRectangle(cornerRadius: 2)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(Color.gray.opacity(0.2))
                    .frame(maxWidth: .infinity, minHeight: 25)
                    .overlay(
                        Text(suggestion)
                            .padding(5)
                            .font(.custom("feather", size: 10))
                            .foregroundColor(.black)
                            .onTapGesture {
                                onSelect(suggestion)
                            }, alignment: .leading
                    )
            }
        }
    }
}

extension View {
    func underlineTextField() -> some View {
        self
            .padding(.vertical, 10)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .frame(height: 2)
                    .padding(.top, 35)
                    .foregroundColor(.gray)
            )
    }
}
