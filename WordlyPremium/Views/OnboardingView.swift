//
//  OnboardingView.swift
//  WordlyPremium
//
//  Created by Jahongir Abdujalilov on 19/03/25.
//

import SwiftUI
import Lottie

struct OnboardingView: View {
    var body: some View {
        ZStack {
            Color.owl.ignoresSafeArea()
            LottieView(animation: .named("panda"))
                .looping()
            VStack {
                Spacer()
                Spacer()
                Text("Generating...")
                    .font(.custom("feather", size: 25))
                    .foregroundStyle(.white)
                Spacer()
            }
        }
    }
}

#Preview {
    OnboardingView()
}

struct AnimationLoader: ViewModifier {
    @Binding var isAnimating: Bool
    
    func body(content: Content) -> some View {
        if isAnimating {
            OnboardingView()
        } else {
            content
        }
    }
}

extension View {
    public func addLoader(_ isAnimating: Binding<Bool>) -> some View {
        modifier(AnimationLoader(isAnimating: isAnimating))
    }
}
