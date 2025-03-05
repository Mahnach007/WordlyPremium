//
//  CardButtonExtended.swift
//  WordlyPremium
//
//  Created by Dilyorbek Sharofiddinov on 04/03/25.
//

import SwiftUI

struct CardButtonExtended: View {
    @State private var isPressed = false
    var cardTitle: String
    var numberOfWords: Int
    var icon: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.gray)
                .frame(height: 80)
                .offset(y: 11)
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.white)
                .frame(height: 90)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.gray, lineWidth: 4)
                )
                .offset(y: isPressed ? 4 : 0)
            HStack {
                VStack(alignment: .leading) {
                    Text(cardTitle)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.black)
                    Text("\(numberOfWords) words")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.gray)
                }
                Spacer()
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 45, height: 50)
                    .clipped()
            }
            .offset(y: isPressed ? 4 : 0)
            .padding()
        }
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    withAnimation(.easeInOut(duration: 0.1)) {
                        isPressed = true
                    }
                }
                .onEnded { _ in
                    withAnimation(.easeInOut(duration: 0.1)) {
                        isPressed = false
                    }
                }
        )
    }
}

#Preview {
    CardButtonExtended(cardTitle: "E", numberOfWords: 20, icon: "cards")
}
