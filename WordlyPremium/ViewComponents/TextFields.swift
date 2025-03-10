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
                .fill(AppColors.white)
                .stroke(AppColors.gray, style: .init(lineWidth: 1))
        }
    }
}

///

struct TextArea: View {

    @State var inputText: String = ""

    var guidingText: String = "Enter your prompt"
    let imageName: String = "magnifier"

    var body: some View {
        HStack {
            TextEditor(text: $inputText)
                .font(.custom("feather", size: 16))
                .padding(4)
                .frame(height: 100)
                .overlay(
                    Text(guidingText)
                        .font(.custom("Feather", size: 16))
                        .foregroundColor(AppColors.gray)
                        .opacity(inputText.isEmpty ? 1 : 0)
                        .padding(.top, 12)
                        .padding(.leading, 10),
                    alignment: .topLeading
                )
        }
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(AppColors.white)
                .stroke(AppColors.gray, style: .init(lineWidth: 1))
        }
    }
}

///

struct SelectorWithModal: View {

    @State private var isModalPresented = false
    @State private var selectedOption: OptionType? = nil
    @State private var placeholderText: String = "Select type"
    var modalType: Int

    let imageName: String = "chevron.down"

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(AppColors.white)
                .frame(height: 50)
                .font(.custom("feather", size: 16))
            HStack {
                Text(placeholderText)
                    .padding(.leading)
                    .font(.custom("feather", size: 16))
                    .foregroundStyle(AppColors.gray)
                Spacer()
                Image(systemName: imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 15, height: 15)
                    .padding(.trailing)
            }
        }
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(AppColors.white)
                .stroke(AppColors.eel, style: .init(lineWidth: 1))
        }
        .onTapGesture {
            isModalPresented = true
        }
        .sheet(isPresented: $isModalPresented) {
            if (modalType == 0) {
                SelectCardInModalView(
                    isPresented: $isModalPresented,
                    selectedOption: $selectedOption
                )
                .presentationDetents([.fraction(0.5)])
                .presentationDragIndicator(.visible)
            } else if (modalType == 1) {
                SelectLanguageInModalView(
                    isPresented: $isModalPresented,
                    selectedOption: $selectedOption
                    
                )
                .presentationDetents([.fraction(0.5)])
                .presentationDragIndicator(.visible)
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
//                        .foregroundColor(AppColors.gray)
//                        .padding(.top, 12)
//                        .padding(.leading),
//                    alignment: .topLeading
//                )
//        }
//        .background {
//            RoundedRectangle(cornerRadius: 8)
//                .fill(AppColors.white)
//                .stroke(AppColors.gray, style: .init(lineWidth: 1))
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
                .font(.custom("feather", size: 16))
                .padding(4)
                .frame(height: 45)
                .overlay(
                    Text(guidingText)
                        .font(.custom("Feather", size: 16))
                        .foregroundColor(AppColors.gray)
                        .opacity(inputText.isEmpty ? 1 : 0)
                        .padding(.top, 12)
                        .padding(.leading),
                    alignment: .topLeading
                )
        }
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(AppColors.white)
                .stroke(AppColors.gray, style: .init(lineWidth: 1))
        }
    }
}

#Preview {
    TextArea()
}
