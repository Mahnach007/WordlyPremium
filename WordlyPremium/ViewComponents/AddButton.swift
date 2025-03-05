//
//  AddButton.swift
//  Wordly
//
//  Created by Diego Arroyo on 28/02/25.
//

import SwiftUI

struct AddButton: View {
    @State private var isPressed = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 3)
                .foregroundStyle(AppColors.darkGreen)
                .frame(width: 35, height: 30)
                .offset(y: 4)
            ZStack {
                RoundedRectangle(cornerRadius: 3)
                    .foregroundStyle(AppColors.ligthGreen)
                    .frame(width: 35, height: 35)
                    .offset(y: -3)
                Text("+")
                    .font(.custom("Feather", size: 42))
                    .foregroundStyle(.white)
                    .offset(y: -7)
            }
            .offset(y: isPressed ? 6 : 0)
        }
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    withAnimation(.easeInOut(duration: 0.1)) {
                        isPressed = true
                    }
                }
                .onEnded { _ in
                    withAnimation(.easeInOut(duration: 0.1)) {
                        isPressed = false
                    }
                }
        )
    }
}

#Preview {
    AddButton()
}
