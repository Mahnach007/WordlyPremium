import SwiftUI

struct FlashcardPlayView: View {
    @Environment(\.dismiss) var dismiss
    @State var flashCards: [FlashcardEntity]
    @State private var offset = CGSize.zero
    @State private var cardBorderColor: Color = .clear
    @StateObject private var viewModel: FlashCardViewModel

    init(flashCards: [FlashcardEntity]) {
        self._flashCards = State(initialValue: flashCards)
        self._viewModel = StateObject(
            wrappedValue: FlashCardViewModel(flashCards: flashCards))
    }
    var body: some View {
        VStack {
            ProgressBar(progress: viewModel.progress)
                .padding(.horizontal, 20)
                .padding(.top, 20)
            HStack {
                LearnCardCounterView(
                    count: viewModel.cardsToLearn.count,
                    backgroundColor: .cardinal, topLineColor: .crab)
                Spacer()
                LearnCardCounterView(count: viewModel.rememberedCards.count)
            }
            .padding(.top, 15)
            .padding(.horizontal, -27)
            Spacer()
            ZStack {
                if !viewModel.isRoundComplete && !viewModel.allCardsLearned {
                    ForEach(
                        Array(viewModel.currentCards.enumerated()),
                        id: \.element.id
                    ) { index, card in
                        FlashCard(
                            card: card,
                            question: card.question,
                            answer: card.answer,
                            borderColor: index == 0
                                ? $cardBorderColor : .constant(.clear),
                            onSpeak: viewModel.speak
                        )
                        .padding()
                        .offset(
                            x: index == 0 ? offset.width : 0,
                            y: index == 0
                                ? offset.height * 0.4 : -CGFloat(index * 4)
                        )
                        .rotationEffect(
                            index == 0
                                ? Angle(degrees: Double(offset.width / 40))
                                : .zero
                        )
                        .zIndex(Double(viewModel.currentCards.count - index))
                        .scaleEffect(
                            index == 0 ? 1.0 : 1.0 - CGFloat(index) * 0.03
                        )
                        .opacity(index == 0 ? 1.0 : 0.0)
                        .gesture(
                            index == 0
                                ? DragGesture()
                                    .onChanged { gesture in
                                        offset = gesture.translation
                                        updateBorderColor(width: offset.width)
                                    }
                                    .onEnded { _ in
                                        withAnimation(.spring()) {
                                            handleSwipe(
                                                width: offset.width, card: card)
                                        }
                                    }
                                : nil
                        )
                    }
                }
                if viewModel.isRoundComplete {
                    RoundCompletionView(
                        totalCards: viewModel.rememberedCards.count
                            + viewModel.cardsToLearn.count,
                        learnedCards: viewModel.rememberedCards.count,
                        onContinue: {
                            viewModel.startNewRound()
                        },
                        onReset: {
                            viewModel.resetAllCards()
                        }
                    )
                }
                if viewModel.allCardsLearned {
                    VStack(spacing: 20) {
                        Text("Congratulations!")
                            .font(.custom("Feather", size: 28))
                            .foregroundColor(Color.owl)
                        Text(
                            "You've learned all \(viewModel.rememberedCards.count) cards!"
                        )
                        .font(.custom("Feather", size: 20))
                        Spacer()
                            .frame(height: 10)
                        Button(action: {
                            viewModel.resetAllCards()
                        }) {
                            ConfirmButton(cardTitle: "Start again", width: 228, color: Color.aqua, action: {})
                        }
                    }
                    .padding()
                }
            }
            Spacer()
        }
        .padding(.top)
        .frame(maxHeight: .infinity, alignment: .top)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    HStack {
                        Text(Image(systemName: "xmark"))
                            .fontWeight(.bold)
                            .foregroundStyle(Color.eel)
                    }
                }
            }
            ToolbarItem(placement: .principal) {
                Text(
                    "\(viewModel.rememberedCards.count)/\(viewModel.allCards.count)"
                )
                .foregroundStyle(Color.eel)
                .font(.custom("Feather", size: 15))
            }
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Button(action: {
//                    dismiss()
//                }) {
//                    HStack {
//                        Text(Image(systemName: "gearshape.fill"))
//                            .fontWeight(.bold)
//                            .foregroundStyle(Color.eel)
//                    }
//                }
//            }
        }
        .fontWeight(.bold)
        .foregroundStyle(Color.eel)
        .background(Color.background)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .regainSwipeBack()
    }

    func updateBorderColor(width: CGFloat) {
        if width < -70 {
            cardBorderColor = .crab
        } else if width > 70 {
            cardBorderColor = .turtle
        } else {
            cardBorderColor = .clear
        }
    }

    func handleSwipe(width: CGFloat, card: FlashcardEntity) {
        if width < -150 {
            offset = CGSize(width: -500, height: 0)
            cardBorderColor = .crab
            viewModel.processSwipe(card: card, direction: .left)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.spring()) {
                    offset = .zero
                    cardBorderColor = .clear
                }
            }
        } else if width > 150 {
            offset = CGSize(width: 500, height: 0)
            cardBorderColor = .turtle
            viewModel.processSwipe(card: card, direction: .right)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.spring()) {
                    offset = .zero
                    cardBorderColor = .clear
                }
            }
        } else {
            offset = .zero
            cardBorderColor = .clear
        }
    }
}

struct RoundCompletionView: View {
    let totalCards: Int
    let learnedCards: Int
    let onContinue: () -> Void
    let onReset: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("Round Complete!")
                .font(.custom("Feather", size: 28))
                .foregroundColor(Color.darkBlue)
            Text("You've learned \(learnedCards) out of \(totalCards) cards.")
                .font(.custom("Feather", size: 20))
            .multilineTextAlignment(.center)
            .padding(.horizontal)
            Spacer()
                .frame(height: 10)
            VStack(spacing: 20) {
                Button(action: onContinue) {
                    ConfirmButton(cardTitle: "Practice mistakes", width: 248, color: Color.frog, action: onContinue)
                }
                Button(action: onReset) {
                    ConfirmButton(cardTitle: "Restart", width: 248, color: Color.cardinal, action: onReset)
                }
            }
        }
        .padding()
        .cornerRadius(15)
    }
}
struct LearnCardCounterView: View {
    let count: Int

    var backgroundColor: Color = .owl
    var topLineColor: Color = .turtle

    var body: some View {
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 4)
                .foregroundStyle(backgroundColor)
                .frame(width: 50, height: 30)
            RoundedRectangle(cornerRadius: 4)
                .frame(width: 45, height: 3.5)
                .foregroundStyle(topLineColor)
                .padding(.top, 2)
                .padding(.horizontal)
            Text("\(count)")
                .font(.custom("feather", size: 18))
                .foregroundColor(.white)
                .frame(width: 50, height: 30)
        }
    }
}

#Preview {
    FlashcardPlayView(flashCards: [
        FlashcardEntity(question: "hello", answer: "hallo", isStudied: false)
    ])
}
