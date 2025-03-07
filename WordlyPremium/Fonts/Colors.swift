//
//  Colors.swift
//  WordlyPremium
//
//  Created by Vlad Gotovchykov on 03/03/25.
//

import Foundation
import SwiftUICore


struct AppColors {
    static let white = Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    static let polar = Color(#colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1))
    static let gray: Color = Color(#colorLiteral(red: 0.6862745098, green: 0.6862745098, blue: 0.6862745098, alpha: 1))
    static let eel: Color = Color(#colorLiteral(red: 0.2941176471, green: 0.2941176471, blue: 0.2941176471, alpha: 1))
    static let ligthGreen: Color = Color(#colorLiteral(red: 0.3450980392, green: 0.8, blue: 0.007843137255, alpha: 1))
    static let darkGreen: Color = Color(#colorLiteral(red: 0.3450980392, green: 0.6549019608, blue: 0, alpha: 1))
    static let lightBlue: Color = Color(#colorLiteral(red: 0.1098039216, green: 0.6901960784, blue: 0.9647058824, alpha: 1))
    static let gradient: Gradient = .init(colors: [Color(#colorLiteral(red: 0.5647058824, green: 0.4117647059, blue: 0.8039215686, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.6980392157, blue: 0.6980392157, alpha: 1)),Color(#colorLiteral(red: 1, green: 0.7843137255, blue: 0, alpha: 1)),Color(#colorLiteral(red: 0.3450980392, green: 0.8, blue: 0.007843137255, alpha: 1))])
    static let green = Color.green
    static let red = Color.red
    static let blue = Color.blue
    static let black = Color.black
    static let purple = Color.purple
    static let pink = Color.pink
    static let orange = Color.orange
    static let yellow = Color.yellow
}

