//
//  PackSliderViewModel.swift
//  WordlyPremium
//
//  Created by Diego Arroyo on 04/03/25.
//

import Foundation

class PackSliderViewModel: ObservableObject {
    @Published var packs: [CardButtonData] = [
        CardButtonData(title: "Car transport only nouns", numberOfWords: 20, icon: "cards"),
        CardButtonData(title: "Medicine", numberOfWords: 133, icon: "cards"),
        CardButtonData(title: "Sports", numberOfWords: 40, icon: "cards"),
        CardButtonData(title: "Law", numberOfWords: 10, icon: "cards")
    ]

    @Published var folders: [CardButtonData] = [
        CardButtonData(title: "Business", numberOfWords: 50, icon: "folder"),
        CardButtonData(title: "Technology", numberOfWords: 80, icon: "folder"),
        CardButtonData(title: "Education", numberOfWords: 90, icon: "folder")
    ]

    @Published var community: [CardButtonData] = [
        CardButtonData(title: "Slang", numberOfWords: 30, icon: "community cards"),
        CardButtonData(title: "Idioms", numberOfWords: 25, icon: "community cards"),
        CardButtonData(title: "Expressions", numberOfWords: 60, icon: "community cards")
    ]
}
