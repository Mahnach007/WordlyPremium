import SwiftUI

struct AddNewCard: View {
    @Binding var question: String
    @Binding var answer: String
    let isAIGenerated: Bool
    var onRegenerate: (() -> Void)?

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.background)
                .stroke(Color.rhino, lineWidth: 1)
            VStack(alignment: .trailing) {
                UnderlineTextField(text: $question, wordType: "Front")
                UnderlineTextField(text: $answer, wordType: "Back")
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
                .stroke(Color.rhino, lineWidth: 1)
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

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                TextField(
                    "", text: $text
                )
                .font(.custom("feather", size: 16))
                .foregroundColor(.eel)
                .underlineTextField()
            }

            HStack {
                Text(wordType)
                    .font(.custom("feather", size: 10))
                    .foregroundColor(.gray)
                Spacer()
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
                    .foregroundColor(Color.rhino.opacity(0.2))
                    .frame(maxWidth: .infinity, minHeight: 25)
                    .overlay(
                        Text(suggestion)
                            .padding(5)
                            .font(.custom("feather", size: 10))
                            .foregroundColor(.rhino)
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
                    .foregroundColor(.rhino)
            )
    }
}

#Preview {
    ContentView()
}
