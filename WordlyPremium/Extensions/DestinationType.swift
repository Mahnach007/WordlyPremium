//
//  DestinationType.swift
//  WordlyPremium
//
//  Created by Diego Arroyo on 07/03/25.
//

import SwiftUI

enum DestinationType: Hashable {
    case firstOption
    case secondOption
    case thirdOption

    @ViewBuilder
    var view: some View {
        switch self {
        case .firstOption:
            AIGenerationCardView()
        case .secondOption:
            CardList()
        case .thirdOption:
            CardList()
        }
    }
}

enum SelectionType {
    case wordType
    case languageType
}

enum WordType: Hashable {
    case firstOption
    case secondOption
    case thirdOption
    case fourthOption

    @ViewBuilder
    var view: some View {
        switch self {
        case .firstOption:
            AIGenerationCardView()
        case .secondOption:
            CardList()
        case .thirdOption:
            CardList()
        case .fourthOption:
            CardList()
        }
    }
}

enum LanguageType: Hashable {
    case firstOption
    case secondOption
    case thirdOption
    
    @ViewBuilder
    var view: some View {
        switch self {
        case .firstOption:
            CardList()
        case .secondOption:
            CardList()
        case .thirdOption:
            CardList()
        }
    }
}

