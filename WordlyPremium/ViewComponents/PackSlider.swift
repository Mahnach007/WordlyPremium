//
//  PackSlider.swift
//  Wordly
//
//  Created by Diego Arroyo on 28/02/25.
//

import SwiftUI

struct PackSlider: View {
    var packTitle: String
    var packNumber: Int
    var cards: [CardButtonData]

    var body: some View {
        VStack {
            PackTitle(packTitle: packTitle, packNumber: packNumber)
                .padding()
                .offset(y: 25)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(cards) { card in
                        CardButton(
                            cardTitle: card.title,
                            numberOfWords: card.numberOfWords, icon: card.icon)
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    PackSlider(
        packTitle: "Your Packs", packNumber: 34,
        cards: [
            CardButtonData(
                title: "Car transport only nouns", numberOfWords: 20,
                icon: "cards"),
            CardButtonData(
                title: "Medicine", numberOfWords: 133, icon: "cards"),
            CardButtonData(title: "Sports", numberOfWords: 40, icon: "cards"),
            CardButtonData(title: "Law", numberOfWords: 10, icon: "cards"),
        ])
}
