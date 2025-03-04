//
//  PackSliderView.swift
//  Wordly
//
//  Created by Diego Arroyo on 28/02/25.
//

import SwiftUI

struct PackSliderView: View {
    var packTitle: String
    var packNumber: Int
    
    var body: some View {
        VStack {
            PackTitleView(packTitle: packTitle, packNumber: packNumber)
                .padding()
                .offset(y: 25)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    CardButtonView(cardTitle: "Car transport only nouns", numberOfWords: 20, icon: "cards")
                    CardButtonView(cardTitle: "Medicine", numberOfWords: 133, icon: "cards")
                    CardButtonView(cardTitle: "Sports", numberOfWords: 40, icon: "cards")
                    CardButtonView(cardTitle: "Law", numberOfWords: 10, icon: "cards")
                }
                .padding()
            }
        }
    }
}

#Preview {
    PackSliderView(packTitle: "Your Packs", packNumber: 34)
}
