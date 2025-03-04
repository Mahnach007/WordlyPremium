//
//  CardButton.swift
//  Wordly
//
//  Created by Diego Arroyo on 28/02/25.
//

import SwiftUI

struct CardButton: View {
    @State private var isPressed = false
    var cardTitle: String
    var numberOfWords: Int
    var icon: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(.gray)
                .frame(width: 233, height: 140)
                .offset(y: 12)
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(.white)
                .frame(width: 230, height: 150)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.gray, lineWidth: 4)
                )
                .offset(y: isPressed ? 4 : 0)
            ZStack() {
                    Text(cardTitle)
                        .font(.custom("Feather", size: 20))
                        .foregroundStyle(AppColors.eel)
                        .offset(x: -20, y: -12)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(width: 140)
                        .frame(maxHeight: .infinity, alignment: .top)
                        .frame(height: 90)
                    Text("\(numberOfWords) words")
                        .font(.custom("Feather Bold", size: 16))
                        .foregroundStyle(AppColors.gray)
                        .offset(x: -50, y: 35)
                        .padding(0)
            }
            .offset(y: isPressed ? 4 : 0)
            Image(icon)
                .offset(x: 70, y: 20)
                .offset(y: isPressed ? 4 : 0)
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
    CardButton(cardTitle: "Car transport only nouns", numberOfWords: 20, icon: "cards")
}
