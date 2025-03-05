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
                    .foregroundStyle(AppColors.eel)
                Text("(\(sliderNumber))")
                    .font(.custom("Feather", size: 13))
                    .foregroundStyle(AppColors.gray)
                    .offset(y: 2)
            }
            Spacer()
            NavigateText(label: "See all", destination: seeAllDestination)
        }
    }
}

//#Preview {
//    SliderTitle(sliderTitle: "Your Packs", sliderNumber: 34, seeAllDestination: AnyView(CardList(type: "card")))
//}
