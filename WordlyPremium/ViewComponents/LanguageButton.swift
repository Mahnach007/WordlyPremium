//
//  LanguageButton.swift
//  WordlyPremium
//
//  Created by Ulugbek Abdimurodov on 05/03/25.
//


import SwiftUI

struct LanguageButton: View {
    @State private var isPressed = false
    var flagImage: String // SF Symbol or asset image name
    var languageName: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(AppColors.gray)
                .frame(height: 80)
                .offset(y: 11)
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.white)
                .frame(height: 90)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(AppColors.gray, lineWidth: 4)
                )
                .offset(y: isPressed ? 4 : 0)
            HStack {
                Image(flagImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                
                Text(languageName)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.black)
                
                Spacer()
            }
            .offset(y: isPressed ? 4 : 0)
            .padding()
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

struct LanguageButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            LanguageButton(flagImage: "italy", languageName: "Italian")
        }
    }
}
