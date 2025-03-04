import SwiftUI

struct CardComponent: View {
    @Binding var word: String
    @Binding var definition: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 7)
                .fill(AppColors.white)
                .stroke(AppColors.gray, lineWidth: 1.5)
                .overlay(
                    Image("Regenerate")
                        .padding(7)
                        .padding(.horizontal, 4)
                    , alignment: .topTrailing
                )

            VStack(alignment: .trailing) {
                UnderlineTextField(text: $word, wordType: "Word")
                UnderlineTextField(text: $definition, wordType: "Definition")
            }
            .padding(10)
            
        }
        .padding(.horizontal, 50)
        .frame(maxWidth: .infinity)
    }
}


struct UnderlineTextField: View {
    @Binding var text: String
    @State var wordType = ""
    @State var language = "Choose Language"
    @State private var suggestions: [String] = ["Suggestion 1", "Suggestion 2", "Suggestion 3"] // Sample suggestions
    @State private var showSuggestions: Bool = false // Initially hidden

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Text input field
            HStack {
                TextField("", text: $text, onEditingChanged: { isEditing in
                    withAnimation {
                        showSuggestions = isEditing // Show suggestions only when editing
                    }
                })
                .font(.custom("feather", size: 16))
                .foregroundStyle(AppColors.eel)
                .underlineTextField()
            }

            // Label
            HStack {
                Text(wordType)
                    .font(.custom("feather", size: 10))
                    .foregroundStyle(AppColors.gray)
                Spacer()
            }

            // Suggestions (if available)
            if showSuggestions && !suggestions.isEmpty {
                CardComponentSuggestion(suggestions: suggestions, onSelect: { selectedSuggestion in
                    text = selectedSuggestion
                    withAnimation {
                        showSuggestions = false // Hide suggestions on selection
                    }
                })
                .transition(.move(edge: .top).combined(with: .opacity)) // Smooth animation
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
                    .foregroundStyle(AppColors.gray)
                    .frame(maxWidth: .infinity, minHeight: 25)
                    .overlay (
                        Text(suggestion)
                            .padding(5)
                            .font(.custom("feather", size: 10))
                            .foregroundStyle(AppColors.eel)
                            .onTapGesture {
                                onSelect(suggestion) // Select suggestion
                            }
                        , alignment: .leading
                    )
                
            }
        }

    }
}

// Underline TextField Modifier
extension View {
    func underlineTextField() -> some View {
        self
            .padding(.vertical, 10)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .frame(height: 2)
                    .padding(.top, 35)
            )
            .foregroundStyle(AppColors.gray)
    }
}

struct new: View {
    @State private var items = Array(repeating: ("", ""), count: 20) // Example list

    var body: some View {
        ScrollView {
            LazyVStack() {
                ForEach(items.indices, id: \.self) { index in
                    CardComponent(word: $items[index].0, definition: $items[index].1)
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    new()
    //CardComponent(word: .constant(""), definition: .constant(""))
}
