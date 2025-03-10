//
//  AIGenerationCardView.swift
//  WordlyPremium
//
//  Created by Diego Arroyo on 07/03/25.
//

import SwiftUI

struct AIGenerationCardView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(alignment: .leading) {
                Text("Topic/Prompt*")
                TextArea()
            }
            VStack(alignment: .leading) {
                Text("Card type")
                SelectorWithModal(modalType: 0)
            }
            VStack(alignment: .leading) {
                Text("Amount of cards")
                NumericField()
            }
            HStack {
                VStack(alignment: .leading) {
                    Text("Front side")
                    SelectorWithModal(modalType: 1)
                }
                VStack(alignment: .leading) {
                    Text("Back side")
                    SelectorWithModal(modalType: 1)
                }
            }
            VStack(alignment: .leading) {
                Text("Word type")
                HStack {
                    SingleButton(word: "Noun")
                    SingleButton(word: "Verb")
                    SingleButton(word: "Adjective")
                    SingleButton(word: "Adverb")
                }
            }
            Spacer()
            ConfirmButton(cardTitle: "Generate", icon: "generate")
                .padding(.bottom, 50)
        }
        .font(.custom("Feather", size: 12))
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
        .navigationBarBackButtonHidden(true)
        .regainSwipeBack()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    HStack {
                        Text(Image(systemName: "arrow.left"))
                            .fontWeight(.bold)
                            .foregroundStyle(AppColors.eel)
                    }
                }
            }
            ToolbarItem(placement: .principal) {
                Text("AI Card Generation")
                    .foregroundStyle(AppColors.eel)
                    .font(.custom("Feather", size: 24))
            }
        }
        .padding(.vertical, -50)
    }
}

#Preview {
    AIGenerationCardView()
}
