//
//  Fields.swift
//  WordlyPremium
//
//  Created by Vlad Gotovchykov on 03/03/25.
//

import SwiftUI

struct SearchBar: View {
    @State var searchText: String = ""
    var guidingText: String = "Search your pack..."
    let imageName: String = "magnifier"

    var body: some View {
        HStack {
            Image(imageName)
                .padding(4)
            TextField(guidingText, text: $searchText)
                .font(.custom("feather", size: 16))
                .padding(.trailing, 30)

                .overlay(
                    Image("cross")
                        .opacity(searchText.isEmpty ? 0.0 : 1.1)
                        .offset(x: 5)
                        .padding(5)
                        .animation(
                            .easeIn(duration: 0.2), value: searchText.isEmpty
                        )
                        .onTapGesture {
                            searchText = ""
                        }, alignment: .trailing
                )
        }
        .padding(5)
        .background {
            RoundedRectangle(cornerRadius: 2)
                .fill(Color.background)
                .stroke(Color.rhino, style: .init(lineWidth: 1))
        }
    }
}

struct TextArea: View {
    @Binding var inputText: String
    @FocusState private var isFocused: Bool
    var isMultiline: Bool
    var placeholder: String

    var body: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $inputText)
                .scrollContentBackground(.hidden)
                .focused($isFocused)
                .font(.custom("feather", size: 16))
                .padding(4)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.background)
                        .stroke(Color.rhino, lineWidth: 1)
                )
                .frame(height: isMultiline ? 100 : 45)
            if inputText.isEmpty {
                Text(placeholder)
                    .font(.custom("Feather", size: 16))
                    .foregroundColor(Color.rhino)
                    .padding(.top, 12)
                    .padding(.leading, 10)
            }
        }
    }
}

struct SelectorWithModal<T: Equatable>: View {
    @Binding var selectedOption: T?
    var selectionType: SelectionType
    @State private var isModalPresented = false
    @State private var placeholderText: String = "Select type"
    @State private var placeholderImage: String = ""
    @State private var placeholderColor = Color.rhino
    let paddingValue: CGFloat = (T.self == CardType.self) ? 4 : 14

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.background)
                .frame(height: 50)
                .font(.custom("feather", size: 16))
            HStack {
                Image(placeholderImage)
                    .offset(x: 15)
                Text(placeholderText)
                    .padding(.leading, paddingValue)
                    .font(.custom("feather", size: 16))
                    .foregroundStyle(placeholderColor)
                Spacer()
                Image(systemName: "chevron.down")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 15, height: 15)
                    .padding(.trailing)
            }
        }
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.background)
                .stroke(Color.eel, style: .init(lineWidth: 1))
        }
        .onTapGesture {
            isModalPresented = true
        }
        .sheet(isPresented: $isModalPresented) {
            if T.self == CardType.self {
                SelectWordTypeInModalView(
                    isPresented: $isModalPresented,
                    selectedOption: Binding<CardType?>(
                        get: { selectedOption as? CardType },
                        set: { selectedOption = $0 as? T }
                    )
                )
                .presentationDetents([.fraction(0.65)])
                .presentationDragIndicator(.visible)
            } else if T.self == LanguageType.self {
                SelectLanguageInModalView(
                    isPresented: $isModalPresented,
                    selectedOption: Binding<LanguageType?>(
                        get: { selectedOption as? LanguageType },
                        set: { selectedOption = $0 as? T }
                    )
                )
                .presentationDetents([.fraction(0.5)])
                .presentationDragIndicator(.visible)
            }
        }
        .background(Color.background)
        .onChange(of: selectedOption) {
            updatePlaceholder()
        }
    }

    private func updatePlaceholder() {
        if let newValue = selectedOption {
            placeholderColor = Color.eel
            switch selectionType {
            case .cardType:
                if let wordType = newValue as? CardType {
                    switch wordType {
                    case .singleWord:
                        placeholderText = "Single Word"
                    case .phrase:
                        placeholderText = "Phrase"
                    case .sentence:
                        placeholderText = "Full Sentence"
                    case .mixed:
                        placeholderText = "Mixed"
                    }
                }
            case .languageType:
                if let language = newValue as? LanguageType {
                    switch language {
                    case .english:
                        placeholderText = "English"
                        placeholderImage = "gb"
                    case .ukrainian:
                        placeholderText = "Ukranian"
                        placeholderImage = "ua"
                    case .italian:
                        placeholderText = "Italian"
                        placeholderImage = "it"
                    }
                }
            }
        }
    }
}

struct NumericField: View {
    @Binding var inputText: String
    @FocusState var isFocused: Bool

    var guidingText: String = "Enter card amount"
    let imageName: String = "magnifier"

    var body: some View {
        HStack {
            TextField("", text: $inputText)
                .focused($isFocused)
                .keyboardType(.numberPad)
                .scrollContentBackground(.hidden)
                .font(.custom("feather", size: 16))
                .padding(.horizontal, 10)
                .frame(height: 45)
                .onChange(of: inputText, initial: false) {
                    newValue, initialValue in
                    if newValue.isEmpty {
                        inputText = ""
                    } else if let number = Int(newValue), number >= 0,
                        number <= 50
                    {
                        inputText = "\(number)"
                    }
                }
                .overlay(
                    Text(guidingText)
                        .font(.custom("Feather", size: 16))
                        .foregroundColor(Color.rhino)
                        .opacity(inputText.isEmpty ? 1 : 0)
                        .padding(.top, 12)
                        .padding(.leading, 10),
                    alignment: .topLeading
                )
        }
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.background)
                .stroke(Color.rhino, style: .init(lineWidth: 1))
        }
    }
}
