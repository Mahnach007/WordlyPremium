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

enum OptionType: Hashable {
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

