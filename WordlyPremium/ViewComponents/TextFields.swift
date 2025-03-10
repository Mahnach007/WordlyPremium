//
//  TextFields.swift
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
                .stroke(Color.gray, style: .init(lineWidth: 1))
        }
    }
}

///

struct TextArea: View {

    @State var inputText: String = ""
    var guidingText: String = "Enter your prompt"

    var body: some View {
        HStack {
            TextEditor(text: $inputText)
                .scrollContentBackground(.hidden)
                .font(.custom("feather", size: 16))
                .padding(4)
                .frame(height: 100)
                .overlay(
                    Text(guidingText)
                        .font(.custom("Feather", size: 16))
                        .foregroundColor(Color.gray)
                        .opacity(inputText.isEmpty ? 1 : 0)
                        .padding(.top, 12)
                        .padding(.leading, 10),
                    alignment: .topLeading
                )
        }
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.background)
                .stroke(Color.gray, style: .init(lineWidth: 1))
        }
    }
}

///

struct SelectorWithModal<T: Equatable>: View {
    @Binding var selectedOption: T?
    var selectionType: SelectionType
    @State private var isModalPresented = false
    @State private var placeholderText: String = "Select type"
    @State private var placeholderImage: String = ""
    @State private var placeholderColor = Color.gray
    let paddingValue: CGFloat = (T.self == WordType.self) ? 4 : 14

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
            if T.self == WordType.self {
                SelectWordTypeInModalView(
                    isPresented: $isModalPresented,
                    selectedOption: Binding<WordType?>(
                        get: { selectedOption as? WordType },
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
            case .wordType:
                if let wordType = newValue as? WordType {
                    switch wordType {
                    case .firstOption:
                        placeholderText = "Single Word"
                    case .secondOption:
                        placeholderText = "Phrase"
                    case .thirdOption:
                        placeholderText = "Full Sentence"
                    case .fourthOption:
                        placeholderText = "Mixed"
                    }
                }
            case .languageType:
                if let language = newValue as? LanguageType {
                    switch language {
                    case .firstOption:
                        placeholderText = "English"
                        placeholderImage = "gb"
                    case .secondOption:
                        placeholderText = "Ukranian"
                        placeholderImage = "ua"
                    case .thirdOption:
                        placeholderText = "Italian"
                        placeholderImage = "it"
                    }
                }
            }
        }
    }
}

///

//struct NumericField: View {
//
//    @State private var inputText = 0
//
//    var guidingText: String = "Enter your prompt"
//    let imageName: String = "magnifier"
//
//    var body: some View {
//        HStack {
//            TextField("e", value: $inputText, format: .number)
//                .font(.custom("feather", size: 16))
//                .padding(4)
//                .frame(height: 100)
//                .overlay(
//                    Text(guidingText)
//                        .font(.custom("Feather", size: 16))
//                        .foregroundColor(Color.gray)
//                        .padding(.top, 12)
//                        .padding(.leading),
//                    alignment: .topLeading
//                )
//        }
//        .background {
//            RoundedRectangle(cornerRadius: 8)
//                .fill(Color.white)
//                .stroke(Color.gray, style: .init(lineWidth: 1))
//        }
//    }
//}

struct NumericField: View {

    @State var inputText: String = ""

    var guidingText: String = "Enter card amount"
    let imageName: String = "magnifier"

    var body: some View {
        HStack {
            TextEditor(text: $inputText)
                .keyboardType(.numberPad)
                .scrollContentBackground(.hidden)
                .font(.custom("feather", size: 16))
                .padding(4)
                .frame(height: 45)
                .overlay(
                    Text(guidingText)
                        .font(.custom("Feather", size: 16))
                        .foregroundColor(Color.gray)
                        .opacity(inputText.isEmpty ? 1 : 0)
                        .padding(.top, 12)
                        .padding(.leading),
                    alignment: .topLeading
                )
        }
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.background)
                .stroke(Color.gray, style: .init(lineWidth: 1))
        }
    }
}

#Preview {
    AIGenerationCardView()
    //    SelectorWithModal(selectionType: )
//        NumericField()
}
