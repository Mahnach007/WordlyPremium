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

struct CardButtonExtended: View {
    @State private var isPressed = false
    var cardTitle: String
    var description: String
    var icon: String
    var isGradient: Bool
    var isFolder: Bool

    var body: some View {
        let backgroundGradient: LinearGradient =
            isGradient
            ? AppColors.gradient
            : LinearGradient(
                gradient: Gradient(colors: [AppColors.gray, AppColors.gray]),
                startPoint: .leading,
                endPoint: .trailing
            )

        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(backgroundGradient)
                .frame(height: 80)
                .offset(y: 10)
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(AppColors.white)
                .frame(height: 90)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(backgroundGradient, lineWidth: 3)
                )
                .offset(y: isPressed ? 4 : 0)
            HStack {
                VStack(alignment: .leading) {
                    Text(cardTitle)
                        .font(.custom("Feather", size: 20))
                        .foregroundColor(.black)
                    Text(description)
                        .foregroundColor(.gray)
                        .font(.custom("Feather", size: 16))
                }
                Spacer()
                if isFolder {
                    Image(icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 45, height: 50)
                        .clipped()
                }
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

struct ButtonWithImage: View {
    @State private var isPressed = false
    var cardTitle: String
    var icon: String
    var isGradient: Bool

    var body: some View {
        let backgroundGradient: LinearGradient =
            isGradient
            ? AppColors.gradient
            : LinearGradient(
                gradient: Gradient(colors: [AppColors.gray, AppColors.gray]),
                startPoint: .leading,
                endPoint: .trailing
            )

        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(backgroundGradient)
                .frame(height: 70)
                .offset(y: 10)
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(AppColors.white)
                .frame(height: 80)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(backgroundGradient, lineWidth: 3)
                )
                .offset(y: isPressed ? 4 : 0)
            VStack(alignment: .leading) {
                Text(cardTitle)
                    .font(.custom("Feather", size: 26))
                    .foregroundStyle(AppColors.eel)
                    .offset(x: 105)
                    .offset(y: isPressed ? 4 : 0)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .overlay(
            Image(icon)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .offset(x: 20)
                .offset(y: isPressed ? 4 : 0)
                .padding(.leading, 8),
            alignment: .leading
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

struct ConfirmButton: View {
    @State private var isPressed = false
    var cardTitle: String
    var icon: String

    var body: some View {
        let backgroundGradient: LinearGradient = AppColors.gradient

        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(backgroundGradient)
                .frame(width: 208, height: 65)
                .offset(y: 5)

            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(AppColors.white)
                .frame(width: 205, height: 65)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(backgroundGradient, lineWidth: 3)
                )
                .offset(y: isPressed ? 4 : 0)
            ZStack {
                Text(cardTitle)
                    .font(.custom("Feather", size: 22))
                    .offset(x: 20)
                    .foregroundStyle(AppColors.eel)
                    .multilineTextAlignment(.leading)
            }
            .offset(y: isPressed ? 4 : 0)
        }
        .overlay(
            Image(icon)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .offset(x: 20, y: -5)
                .offset(y: isPressed ? 4 : 0)
                .padding(.bottom, 12)
                .padding(.leading, 8),
            alignment: .bottomLeading
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

struct SingleButton: View {
    @State private var isPressed = false
    var word: String

    var body: some View {

        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(isPressed ? AppColors.blue : AppColors.gray)
                .frame(width: 86, height: 40)
                .offset(y: 3)
            RoundedRectangle(cornerRadius: 10)
                .fill(isPressed ? AppColors.lightBlue : AppColors.white)
                .frame(width: 85, height: 40)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(isPressed ? AppColors.blue : AppColors.gray, lineWidth: 2)
                )
                .offset(y: isPressed ? 3 : 0)
            ZStack {
                Text(word)
                    .font(.custom("Feather", size: 15))
                    .foregroundStyle(AppColors.eel)
                    .multilineTextAlignment(.leading)
            }
            .offset(y: isPressed ? 3 : 0)
        }
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.1)) {
                if (!isPressed) {
                    isPressed = true
                } else {
                    isPressed = false
                }
            }
        }
    }
}

#Preview {
//    ButtonWithImage(
//        cardTitle: "Englishoens", icon: "gb", isGradient: false)
//    ButtonWithImage(
//        cardTitle: "Italian", icon: "it", isGradient: false)
//    ButtonWithImage(
//        cardTitle: "Ukranian", icon: "ua", isGradient: false)
//    ConfirmButton(cardTitle: "e", icon: "gb")
    SingleButton(word: "Adjective")
}

//#Preview {
//    CardButtonExtended(
//        cardTitle: "AI Flashcards", description: "Generate flashcards instantly", icon: "cards", isGradient: false, isFolder: false)
//}
