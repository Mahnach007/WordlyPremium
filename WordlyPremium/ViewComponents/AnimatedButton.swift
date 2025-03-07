//
//  AnimatedMeshGradient.swift
//  WordlyPremium
//
//  Created by Ulugbek Abdimurodov on 04/03/25.

import SwiftUI

struct AnimatedButton: View {
    @State private var isPressed = false
    
    var btnName: String
    var subtitle: String?
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .stroke(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.purple,
                            Color.pink,
                            Color.orange,
                            Color.yellow,
                            Color.green
                        ]),
                        startPoint: .leading,
                        endPoint: .trailing
                    ),
                    lineWidth: 3
                )
                .frame(height: 80)
                .offset(y:3)
            
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(AppColors.white)
                .frame(height: 80)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.purple,
                                    Color.pink,
                                    Color.orange,
                                    Color.yellow,
                                    Color.green
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing
                            ),
                            lineWidth: 3
                        )
                )
                .offset(y: isPressed ? 4 : 0)
            
            ZStack {
                VStack {
                    HStack {
                        Image(systemName: "sparkles")
                            .foregroundColor(.black)
                        
                        Text(btnName)
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)
                    }
                    
                    if let subtitle = subtitle, !subtitle.isEmpty {
                        Text(subtitle)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            .offset(y: isPressed ? 4 : 0)
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

struct AnimatedButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            AnimatedButton(
                btnName: "AI Flashcards",
                subtitle: "Generate flashcards instantly"
            )
            
            AnimatedButton(
                btnName: "AI Flashcards",
                subtitle: nil // No subtitle case
            )
        }
    }
}
