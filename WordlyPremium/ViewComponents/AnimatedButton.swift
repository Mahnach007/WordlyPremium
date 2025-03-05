//
//  AnimatedMeshGradient.swift
//  WordlyPremium
//
//  Created by Ulugbek Abdimurodov on 04/03/25.

import SwiftUI

struct AnimatedMeshGradient: View {
    @State private var isPressed = false
    
    var btnName: String
    var subtitle: String?
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                Button(action: {}) {
                    VStack(spacing: 4) {
                        // Main button text
                        HStack {
                            Image(systemName: "sparkles")
                                .foregroundColor(.black)
                            
                            Text(btnName)
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.black)
                        }
                        
                        // Subtitle inside the button (if available)
                        if let subtitle = subtitle, !subtitle.isEmpty {
                            Text(subtitle)
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.white)
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
                            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                    )
                    .scaleEffect(isPressed ? 0.95 : 1.0) // Press effect
                    .gesture(
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
            .padding()
        }
    }
}

struct AnimatedMeshGradient_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            AnimatedMeshGradient(
                btnName: "AI Flashcards",
                subtitle: "Generate flashcards instantly"
            )
            
            AnimatedMeshGradient(
                btnName: "AI Flashcards",
                subtitle: nil // No subtitle case
            )
        }
    }
}
