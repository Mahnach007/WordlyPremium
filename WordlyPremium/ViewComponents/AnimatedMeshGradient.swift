//
//  AnimatedMeshGradient.swift
//  WordlyPremium
//
//  Created by Ulugbek Abdimurodov on 04/03/25.

import SwiftUI

struct AnimatedMeshGradient: View {
    @State private var isLoading = false
    
    var body: some View {
        
        ZStack {
            Color(.systemGray6).edgesIgnoringSafeArea(.all)
            
            VStack() {
                Button(action: {} ) {
                    HStack {
                        if isLoading {
                            ProgressView()
                                .tint(.white)
                        } else {
                            Image(systemName: "sparkless")
                        }
                        Text(isLoading ? "Generating ..." : "Generate Words")
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        AnimatedMesh()
                        .mask(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(lineWidth: 16)
                                .blur(radius: 8)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(.white, lineWidth: 2)
                                .blur(radius: 2)
                                .blendMode(.overlay)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(.white, lineWidth: 2)
                                .blur(radius: 1)
                                .blendMode(.overlay)
                        )
                    )
                    .background(.white)
                    .cornerRadius(16)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.black.opacity(0.5), lineWidth: 1)
                    )
                    .shadow(radius: 20)
                }
            }
        }
    }
}

struct AnimatedMeshGradient_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedMeshGradient()
    }
}
