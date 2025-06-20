//
//  SliderTitle.swift
//  Wordly
//
//  Created by Diego Arroyo on 03/03/25.
//

import SwiftUI

struct SliderTitle: View {
    var sliderTitle: String
    var sliderNumber: Int
    @State private var showSeeAll = false
    var seeAllDestination: AnyView

    var body: some View {
        HStack {
            HStack {
                Text(sliderTitle)
                    .font(.custom("Feather", size: 21))
                    .foregroundStyle(Color.eel)
                Text("(\(sliderNumber))")
                    .font(.custom("Feather", size: 13))
                    .foregroundStyle(Color.rhino)
                    .offset(y: 2)
            }
            Spacer()
            TextLink(label: "See all", destination: seeAllDestination)
        }
    }
}
