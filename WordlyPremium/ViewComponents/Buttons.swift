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
        isPressed: Binding<Bool>, @ViewBuilder content: @escaping () -> Content,
        action: @escaping () -> Void = {}
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
                        hasTriggeredHaptic = false
                        action()
                    }
            )
    }
}

struct CardButton: View {
    @State private var isPressed = false
    var cardTitle: String
    var numberOfWords: Int
    var icon: String

    var body: some View {
        PressableButton(isPressed: $isPressed) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(Color.rhino)
                    .frame(width: 178, height: 115)
                    .offset(y: 5)

                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(Color.background)
                    .frame(width: 175, height: 115)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.rhino, lineWidth: 3)
                    )
                    .offset(y: isPressed ? 4 : 0)

                ZStack {
                    Text(cardTitle)
                        .font(.custom("Feather", size: 16))
                        .foregroundStyle(Color.eel)
                        .offset(x: -3, y: 4)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(width: 140)
                        .frame(maxHeight: .infinity, alignment: .top)
                        .frame(height: 90)

                    Text(
                        icon == "folder"
                            ? "\(numberOfWords) packs"
                            : "\(numberOfWords) cards"
                    )
                    .font(.custom("Feather Bold", size: 16))
                    .foregroundStyle(Color.gray)
                    .offset(x: -42, y: 30)
                    .padding(0)
                }
                .offset(y: isPressed ? 4 : 0)
            }
            .overlay(
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .offset(x: -4)
                    .offset(y: isPressed ? 4 : 0)
                    .padding(.bottom, 12)
                    .padding(.trailing, 8),
                alignment: .bottomTrailing
            )
        }
    }
}

struct AddButton: View {
    @State private var isPressed = false
    var isRounded: Bool

    var body: some View {
        PressableButton(isPressed: $isPressed) {
            ZStack {
                RoundedRectangle(cornerRadius: isRounded ? 30 : 3)
                    .foregroundStyle(Color.frog)
                    .frame(
                        width: isRounded ? 60 : 35, height: isRounded ? 60 : 35
                    )
                    .offset(y: isRounded ? 3 : 4)
                ZStack {
                    RoundedRectangle(cornerRadius: isRounded ? 30 : 3)
                        .foregroundStyle(Color.owl)
                        .frame(
                            width: isRounded ? 60 : 35,
                            height: isRounded ? 60 : 35
                        )
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

struct CardButtonExtended: View {
    @State private var isPressed = false
    var cardTitle: String
    var description: String?
    var icon: String
    var isGradient: Bool
    var hasIcon: Bool
    var color: Color?

    var body: some View {
        let buttonColor = color ?? Color.rhino
        let buttonDescription = description ?? "description"

        let backgroundGradient: LinearGradient =
            isGradient
            ? AppColors.gradient
            : LinearGradient(
                gradient: Gradient(colors: [buttonColor, buttonColor]),
                startPoint: .leading,
                endPoint: .trailing
            )

        PressableButton(isPressed: $isPressed) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundStyle(backgroundGradient)
                    .frame(height: (description != nil) ? 80 : 55)
                    .offset(y: 10)
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(Color.background)
                    .frame(height: (description != nil) ? 90 : 65)
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
                        if description != nil {
                            Text(buttonDescription)
                                .foregroundColor(buttonColor)
                                .font(.custom("Feather", size: 16))
                        }
                    }
                    Spacer()
                    if hasIcon {
                        Image(icon)
                            .resizable()
                            .scaledToFit()
                            .frame(
                                width: (description != nil) ? 65 : 45,
                                height: 65
                            )
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

    var body: some View {
        let backgroundGradient: LinearGradient =
            isGradient
            ? AppColors.gradient
            : LinearGradient(
                gradient: Gradient(colors: [Color.rhino, Color.rhino]),
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
                isChecked
                    ? Text(Image(systemName: "checkmark"))
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(Color.azure)
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
    var icon: String?
    var width: CGFloat
    var color: Color?
    let action: () -> Void

    var body: some View {
        let parsedColor: LinearGradient = {
            if let color = color {
                return LinearGradient(
                    colors: [color, color], startPoint: .leading,
                    endPoint: .trailing)
            } else {
                return AppColors.gradient
            }
        }()

        PressableButton(isPressed: $isPressed) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(parsedColor)
                    .frame(width: width, height: 65)
                    .offset(y: 5)

                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(Color.background)
                    .frame(width: width - 3, height: 65)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(parsedColor, lineWidth: 3)
                    )
                    .offset(y: isPressed ? 4 : 0)

                ZStack {
                    Text(cardTitle)
                        .font(.custom("Feather", size: 22))
                        .offset(x: icon == nil ? 0 : 20)
                        .foregroundStyle(Color.eel)
                        .multilineTextAlignment(.leading)
                }
                .offset(y: isPressed ? 4 : 0)
            }
            .overlay(
                Group {
                    if let iconName = icon {
                        Image(iconName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .offset(x: 20, y: -5)
                            .offset(y: isPressed ? 4 : 0)
                            .padding(.bottom, 12)
                            .padding(.leading, 8)
                    }
                },
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
                    isPressed ? Color.azure : Color.rhino
                )
                .frame(width: 81, height: 40)
                .offset(y: 3)
            RoundedRectangle(cornerRadius: 10)
                .fill(isPressed ? Color.ocean : Color.background)
                .frame(width: 80, height: 40)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(
                            isPressed ? Color.azure : Color.rhino,
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

struct TextLink: View {
    var label: String
    var destination: AnyView

    var body: some View {
        NavigationLink(destination: destination) {
            Text(label)
                .font(.custom("Feather", size: 17))
                .foregroundStyle(Color.azure)
                .underline()
                .offset(y: 3)
        }
    }
}

#Preview {
    //    NavigationStack {
    //        TextLink(label: "Go to View", destination: AnyView(AddButton(isRounded: false)))
    //    }
    //    ButtonWithImage(
    //        cardTitle: "Englishoens", icon: "gb", isGradient: false)
    //    ButtonWithImage(
    //        cardTitle: "Italian", icon: "it", isGradient: false)
    //    ButtonWithImage(
    //        cardTitle: "Ukranian", icon: "ua", isGradient: false, isChecked: false)
    ConfirmButton(cardTitle: "Practice mistakes", width: 228, color: Color.white, action: {})
    //        SingleButton(word: "Adjective")
    //    CardButtonExtended(
    //        cardTitle: "AI Flashcards", icon: "flashcards",
    //        isGradient: false, hasIcon: true)
    //    Button("Button") {
    //
    //    }.buttonStyle(CardButton(
    //        cardTitle: "card.title",
    //        numberOfWords: 20,
    //        icon: "cards"))
    //    CardButton(cardTitle: "Sports", numberOfWords: 8, icon: "cards")
}
