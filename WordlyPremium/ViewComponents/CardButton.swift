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
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(AppColors.gray)
                .frame(width: 178, height: 115)
                .offset(y: 5)

            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(AppColors.white)
                .frame(width: 175, height: 115)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(AppColors.gray, lineWidth: 3)
                )
                .offset(y: isPressed ? 4 : 0)
            ZStack {
                Text(cardTitle)
                    .font(.custom("Feather", size: 16))
                    .foregroundStyle(AppColors.eel)
                    .offset(x: -5)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(width: 140)
                    .frame(maxHeight: .infinity, alignment: .top)
                    .frame(height: 90)
                Text("\(numberOfWords) words")
                    .font(.custom("Feather Bold", size: 16))
                    .foregroundStyle(AppColors.gray)
                    .offset(x: -35, y: 35)
                    .padding(0)
            }
            .offset(y: isPressed ? 4 : 0)
        }
        .overlay(
            Image(icon)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .offset(y: isPressed ? 4 : 0)
                .padding(.bottom, 12)
                .padding(.trailing, 8),
            alignment: .bottomTrailing
        )
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
    CardButton(
        cardTitle: "Car transport only nouns", numberOfWords: 20, icon: "cards")
}
