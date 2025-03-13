//
//  CardList.swift
//  WordlyPremium
//
//  Created by Diego Arroyo on 04/03/25.
//

import SwiftUI

struct CardList: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Your Folders")
                    .font(.custom("Feather", size: 32))
                SearchBar()
            }
            .padding(.bottom, 20)
            VStack(spacing: 20) {
                CardButtonExtended(
                    cardTitle: "cardTitle", description: "1", icon: "cards", isGradient: false, isFolder: true)
                CardButtonExtended(
                    cardTitle: "cardTitle", description: "1", icon: "cards", isGradient: false, isFolder: true)
                CardButtonExtended(
                    cardTitle: "cardTitle", description: "1", icon: "cards", isGradient: false, isFolder: true)
            }
        }
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
                            .foregroundStyle(Color.eel)
                    }
                }
            }
        }
    }
}

#Preview {
    CardList()
}
