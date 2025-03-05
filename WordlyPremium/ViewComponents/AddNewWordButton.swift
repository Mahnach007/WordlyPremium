//
//  AddNewWordButton.swift
//  WordlyPremium
//
//  Created by Vlad Gotovchykov on 05/03/25.
//

import SwiftUI

struct AddNewWordButton: View {
    @State private var isPressed = false
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundStyle(AppColors.darkGreen)
                
            ZStack {
                Circle()
                    .foregroundStyle(AppColors.ligthGreen)
                Image("plus")
            }.offset(x: 0, y: isPressed ? 0 : -5)
            
        }.padding()
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
    AddNewWordButton()
}
