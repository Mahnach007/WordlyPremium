//
//  CardButton.swift
//  Wordly
//
//  Created by Diego Arroyo on 28/02/25.
//

import SwiftUI

struct PressableButton<Content: View>: View {
    let content: () -> Content
    let action: () -> Void

    @Binding var isPressed: Bool
    @State private var hasTriggeredHaptic = false

    init(
        isPressed: Binding<Bool>, @ViewBuilder content: @escaping () -> Content, action: @escaping () -> Void = {}
    ) {
        self._isPressed = isPressed
        self.content = content
        self.action = action
    }

    var body: some View {
        content()
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        withAnimation(.easeInOut(duration: 0.1)) {
                            isPressed = true
                        }
                        if !hasTriggeredHaptic {
                            let impact = UIImpactFeedbackGenerator(
                                style: .medium)
                            impact.impactOccurred()
                            hasTriggeredHaptic = true
                        }
                    }
                    .onEnded { _ in
                        withAnimation(.easeInOut(duration: 0.1)) {
                            isPressed = false
                        }
                        let impact = UIImpactFeedbackGenerator(style: .light)
                        impact.impactOccurred()
                        hasTriggeredHaptic = false
                        action()
                    }
            )
    }
}

struct AddButton: View {
    @State private var isPressed = false
    @State private var hasTriggeredHaptic = false

    var body: some View {
        PressableButton(isPressed: $isPressed) {
            ZStack {
                RoundedRectangle(cornerRadius: 3)
                    .foregroundStyle(Color.darkGreen)
                    .frame(width: 35, height: 30)
                    .offset(y: 4)
                ZStack {
                    RoundedRectangle(cornerRadius: 3)
                        .foregroundStyle(Color.lightGreen)
                        .frame(width: 35, height: 35)
                        .offset(y: -3)
                    Text("+")
                        .font(.custom("Feather", size: 42))
                        .foregroundStyle(.white)
                        .offset(y: -7)
                }
                .offset(y: isPressed ? 6 : 0)
            }
        }
    }
}

struct CardButton: View {
    @State private var isPressed = false
    var cardTitle: String
    var numberOfWords: Int
    var icon: String
    let impact = UIImpactFeedbackGenerator(style: .light)
    @State private var hasTriggeredHaptic = false

    var body: some View {
        PressableButton(isPressed: $isPressed) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(Color.gray)
                    .frame(width: 178, height: 115)
                    .offset(y: 5)

                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(Color.background)
                    .frame(width: 175, height: 115)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 3)
                    )
                    .offset(y: isPressed ? 4 : 0)
                ZStack {
                    Text(cardTitle)
                        .font(.custom("Feather", size: 16))
                        .foregroundStyle(Color.eel)
                        .offset(x: -5)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(width: 140)
                        .frame(maxHeight: .infinity, alignment: .top)
                        .frame(height: 90)
                    Text("\(numberOfWords) words")
                        .font(.custom("Feather Bold", size: 16))
                        .foregroundStyle(Color.gray)
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
        }
    }
}

struct CardButtonExtended: View {
    @State private var isPressed = false
    var cardTitle: String
    var description: String
    var icon: String
    var isGradient: Bool
    var isFolder: Bool
    let impact = UIImpactFeedbackGenerator(style: .light)
    @State private var hasTriggeredHaptic = false

    var body: some View {
        let backgroundGradient: LinearGradient =
            isGradient
            ? AppColors.gradient
            : LinearGradient(
                gradient: Gradient(colors: [Color.gray, Color.gray]),
                startPoint: .leading,
                endPoint: .trailing
            )

        PressableButton(isPressed: $isPressed) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundStyle(backgroundGradient)
                    .frame(height: 80)
                    .offset(y: 10)
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(Color.background)
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
                            .foregroundColor(Color.eel)
                        Text(description)
                            .foregroundColor(Color.gray)
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
        }
    }
}

struct ButtonWithImage: View {
    @State private var isPressed = false
    var cardTitle: String
    var icon: String
    var isGradient: Bool
    var isChecked: Bool
    let impact = UIImpactFeedbackGenerator(style: .light)
    @State private var hasTriggeredHaptic = false

    var body: some View {
        let backgroundGradient: LinearGradient =
            isGradient
            ? AppColors.gradient
            : LinearGradient(
                gradient: Gradient(colors: [Color.gray, Color.gray]),
                startPoint: .leading,
                endPoint: .trailing
            )

        PressableButton(isPressed: $isPressed) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundStyle(backgroundGradient)
                    .frame(height: 70)
                    .offset(y: 10)
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(Color.background)
                    .frame(height: 80)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(backgroundGradient, lineWidth: 3)
                    )
                    .offset(y: isPressed ? 4 : 0)
                VStack(alignment: .leading) {
                    Text(cardTitle)
                        .font(.custom("Feather", size: 26))
                        .foregroundStyle(Color.eel)
                        .offset(x: 105)
                        .offset(y: isPressed ? 4 : 0)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .background(Color.background)
            .overlay {
                isChecked ?
                Text(Image(systemName: "checkmark"))
                    .font(.system(size: 28, weight: .bold))
                    .foregroundStyle(Color.blue)
                    .offset(x: 140)
                : nil
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

        }
    }
}

struct ConfirmButton: View {
    @State private var isPressed = false
    var cardTitle: String
    var icon: String
    let action: () -> Void
    let impact = UIImpactFeedbackGenerator(style: .light)
    @State private var hasTriggeredHaptic = false

    var body: some View {
        let backgroundGradient: LinearGradient = AppColors.gradient

        PressableButton(isPressed: $isPressed) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(backgroundGradient)
                    .frame(width: 208, height: 65)
                    .offset(y: 5)

                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(Color.background)
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
                        .foregroundStyle(Color.eel)
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
        } action: {
            action()
        }
    }
}

struct SingleButton: View {
    @State private var isPressed = false
    var word: String
    var onTap: (() -> Void)? = nil
    let impact = UIImpactFeedbackGenerator(style: .light)

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(
                    isPressed ? Color.blue : Color.gray
                )
                .frame(width: 81, height: 40)
                .offset(y: 3)
            RoundedRectangle(cornerRadius: 10)
                .fill(isPressed ? Color.lightBlue : Color.background)
                .frame(width: 80, height: 40)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(
                            isPressed ? Color.blue : Color.gray,
                            lineWidth: 2)
                )
                .offset(y: isPressed ? 3 : 0)
            ZStack {
                Text(word)
                    .font(.custom("Feather", size: 15))
                    .foregroundStyle(Color.eel)
                    .multilineTextAlignment(.leading)
            }
            .offset(y: isPressed ? 3 : 0)
        }

        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.1)) {
                if !isPressed {
                    isPressed = true
                    impact.impactOccurred()
                } else {
                    isPressed = false
                    impact.impactOccurred()
                }
            }
            onTap?()
        }
    }
}

#Preview {
    //    ButtonWithImage(
    //        cardTitle: "Englishoens", icon: "gb", isGradient: false)
    //    ButtonWithImage(
    //        cardTitle: "Italian", icon: "it", isGradient: false)
//    ButtonWithImage(
//        cardTitle: "Ukranian", icon: "ua", isGradient: false, isChecked: false)
    //    ConfirmButton(cardTitle: "e", icon: "gb")
        SingleButton(word: "Adjective")
}

//#Preview {
//    CardButtonExtended(
//        cardTitle: "AI Flashcards", description: "Generate flashcards instantly", icon: "cards", isGradient: false, isFolder: false)
//}
