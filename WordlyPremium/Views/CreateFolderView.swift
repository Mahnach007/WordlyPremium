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
    @FocusState private var isFocused: Bool
    
    @StateObject var folderViewModel: AddFolderViewModel = AddFolderViewModel()
    
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
                    .focused($isFocused)
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
                
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        isFocused = false  // Dismiss keyboard
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        folderViewModel.createFolder(withName: text)
                        print(folderViewModel.fetchAllFolders().last?.name ?? "Error")
                        dismiss()
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
                    isFocused = true
                }
            }
        }
        .background(Color.background)
    }
}

#Preview {
    CreateFolderView()
}
