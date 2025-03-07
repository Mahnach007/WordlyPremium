//
//  AddPackView.swift
//  WordlyPremium
//
//  Created by Diego Arroyo on 04/03/25.
//

import SwiftUI

struct AddPackView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 25) {
                AnimatedButton(btnName: "AI Flashcards", subtitle: "Generate flashcards instantly")
                CardButtonExtended(cardTitle: "E", numberOfWords: 20, icon: "cards")
                CardButtonExtended(cardTitle: "E", numberOfWords: 20, icon: "cards")
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
