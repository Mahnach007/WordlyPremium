//
//  CardButtonData.swift
//  WordlyPremium
//
//  Created by Diego Arroyo on 04/03/25.
//

import Foundation

struct CardButtonData: Identifiable {
    var id = UUID()
    var title: String
    var numberOfWords: Int
    var icon: String
}
