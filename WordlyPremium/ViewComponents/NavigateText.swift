//
//  NavigateText.swift
//  WordlyPremium
//
//  Created by Diego Arroyo on 04/03/25.
//

import SwiftUI

struct NavigateText: View {
    var label: String
    var destination: AnyView

    var body: some View {
        NavigationLink(destination: destination) {
            Text(label)
                .font(.custom("Feather", size: 17))
                .foregroundStyle(Color.blue)
                .underline()
                .offset(y: 3)
        }
    }
}

#Preview {
    NavigationStack {
        NavigateText(label: "Go to View", destination: AnyView(AddButton()))
    }
}
