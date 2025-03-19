//
//  Colors.swift
//  WordlyPremium
//
//  Created by Vlad Gotovchykov on 03/03/25.
//

import Foundation
import SwiftUICore


struct AppColors {
    static let gradient = LinearGradient(
            gradient: Gradient(colors: [
                Color(#colorLiteral(red: 0.5647058824, green: 0.4117647059, blue: 0.8039215686, alpha: 1)),
                Color(#colorLiteral(red: 1, green: 0.6980392157, blue: 0.6980392157, alpha: 1)),
                Color(#colorLiteral(red: 1, green: 0.7843137255, blue: 0, alpha: 1)),
                Color(#colorLiteral(red: 0.3450980392, green: 0.8, blue: 0.007843137255, alpha: 1))
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
}
