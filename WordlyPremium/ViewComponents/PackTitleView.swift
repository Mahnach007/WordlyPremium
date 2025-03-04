//
//  PackTitleView.swift
//  Wordly
//
//  Created by Diego Arroyo on 03/03/25.
//

import SwiftUI

struct PackTitleView: View {
    var packTitle: String
    var packNumber: Int
    
    var body: some View {
        
        HStack {
            HStack {
                Text(packTitle)
                    .font(.custom("Feather", size: 21))
                    .foregroundStyle(AppColors.eel)
                Text("(\(packNumber))")
                    .font(.custom("Feather", size: 13))
                    .foregroundStyle(AppColors.gray)
                    .offset(y: 2)
            }
            Spacer()
            Text("See all")
                .font(.custom("Feather", size: 17))
                .foregroundStyle(AppColors.lightBlue)
                .underline()
                .offset(y: 3)
        }
    }
}

#Preview {
    PackTitleView(packTitle: "Your Packs", packNumber: 34)
}
