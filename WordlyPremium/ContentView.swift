//
//  ContentView.swift
//  WordlyPremium
//
//  Created by Vlad Gotovchykov on 03/03/25.
//

import SwiftUI

struct ContentView: View {
    @State private var fromLanguage = "English"
    @State private var toLanguage = "Spanish"
    @State private var topic = ""
    @State private var cardAmount: CardAmount = .automatic
    @State private var wordType = "mixed"
    @State private var flashcards: [Flashcard] = []
    @State private var isLoading = false
    @State private var errorMessage: String?

    private let flashcardService = FlashcardService()

    var body: some View {
        VStack {
            Text("Flashcard Generator")
                .font(.largeTitle)
                .padding()

            Form {
                TextField("From Language", text: $fromLanguage)
                TextField("To Language", text: $toLanguage)
                TextField("Topic", text: $topic)
                
                Picker("Number of Cards", selection: $cardAmount) {
                    ForEach(CardAmount.allCases, id: \.self) { amount in
                        Text(amount.rawValue).tag(amount)
                    }
                }
                
                Picker("Word Type", selection: $wordType) {
                    Text("Verbs").tag("verbs")
                    Text("Nouns").tag("nouns")
                    Text("Phrases").tag("phrases")
                    Text("Mixed").tag("mixed")
                }
            }

            if isLoading {
                ProgressView()
                    .padding()
            } else if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            } else {
                List(flashcards) { flashcard in
                    VStack(alignment: .leading) {
                        Text(flashcard.question)
                            .font(.headline)
                        Text(flashcard.answer)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }

            Button("Generate Flashcards") {
                generateFlashcards()
            }
            .padding()
            .disabled(isLoading)
        }
        .padding()
    }

    private func generateFlashcards() {
        isLoading = true
        errorMessage = nil

        // Determine the number of cards
        let numCards: Int
        switch cardAmount {
        case .five:
            numCards = 5
        case .ten:
            numCards = 10
        case .twenty:
            numCards = 20
        case .automatic:
            numCards = 0 // Let the AI decide
        }

        let request = GenerateCardsRequest(
            fromLanguage: fromLanguage,
            toLanguage: toLanguage,
            topic: topic,
            numCards: numCards,
            wordType: wordType,
            options: nil
        )

        flashcardService.generateCards(request: request) { result in
            DispatchQueue.main.async { 
                isLoading = false
                switch result {
                case .success(let cards):
                    flashcards = cards
                case .failure(let error):
                    errorMessage = error.localizedDescription
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

//@StateObject private var viewModel = PackSliderViewModel()
//@State private var showAddView = false
//
//var body: some View {
//    NavigationStack {
//        VStack {
//            HStack {
//                AddButton()
//                    .padding()
//                    .padding(.vertical, -30)
//                    .padding(.top, 20)
//                    .onTapGesture {
//                        showAddView = true
//                    }
//                    .sheet(isPresented: $showAddView) {
//                        AddPackView()
//                            .presentationDetents([.fraction(0.5)])
//                            .presentationDragIndicator(.visible)
//                    }
//            }
//            .frame(maxWidth: .infinity, alignment: .trailing)
//            SearchBar()
//                .padding()
//        }
//        ScrollView {
//            VStack(spacing: 35) {
//                CardSlider(
//                    packTitle: "Your Packs",
//                    packNumber: viewModel.packs.count,
//                    cards: viewModel.packs
//                )
//                CardSlider(
//                    packTitle: "Your Folders",
//                    packNumber: viewModel.folders.count,
//                    cards: viewModel.folders
//                )
//                CardSlider(
//                    packTitle: "Community Packs",
//                    packNumber: viewModel.community.count,
//                    cards: viewModel.community
//                )
//            }
//            .padding(.top, 20)
//        }
//    }
//}
