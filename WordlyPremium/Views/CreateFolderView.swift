//
//  CreateFolderView.swift
//  WordlyPremium
//
//  Created by Diego Arroyo on 14/03/25.
//

import SwiftUI

struct CreateFolderView: View {
    @Environment(\.dismiss) var dismiss
    @State private var text: String = ""
    @FocusState private var isTextFieldFocused: Bool

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 20) {
                VStack(alignment: .leading) {
                    Text("Title")
                        .font(.custom("Feather", size: 12))
                    TextArea(
                        inputText: $text, isMultiline: false,
                        placeholder: "Name your folder"
                    )
                    .focused($isTextFieldFocused)
                }
            }
            .font(.custom("Feather", size: 12))
            .frame(maxHeight: .infinity, alignment: .top)
            .padding()
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Create a folder")
                        .foregroundStyle(Color.eel)
                        .font(.custom("Feather", size: 15))
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        HStack {
                            Text("Cancel")
                                .font(.custom("Feather", size: 15))
                                .foregroundStyle(Color.red)
                        }
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        // Save the name in backend
                    }) {
                        HStack {
                            Text(Image(systemName: "checkmark"))
                                .fontWeight(.bold)
                                .foregroundStyle(Color.aqua)
                        }
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .regainSwipeBack()
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    isTextFieldFocused = true
                }
            }
        }
        .background(Color.background)
    }
}

#Preview {
    CreateFolderView()
}
