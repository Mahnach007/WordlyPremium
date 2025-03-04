//
//  SearchBar.swift
//  WordlyPremium
//
//  Created by Vlad Gotovchykov on 03/03/25.
//

import SwiftUI

struct SearchBar: View {
    
    @State var searchText: String = ""
    
    var guidingText: String = "Search your pack..."
    let imageName: String = "magnifier"
    
    
    var body: some View {
        HStack {
            Image(imageName)
                .padding(4)
            
            TextField(guidingText, text: $searchText)
                .font(.custom("feather", size: 16))
                .padding(.trailing, 30)

                .overlay (
                    Image("cross")
                        .opacity(searchText.isEmpty ? 0.0 : 1.1)
                        .offset(x: 5)
                        .padding(5)
                        .animation(.easeIn(duration: 0.2), value: searchText.isEmpty)
                        .onTapGesture {
                            searchText = ""
                        }
                    ,alignment: .trailing
                )
        }
        .padding(5)
        .background {
            RoundedRectangle(cornerRadius: 2)
                .fill(AppColors.white)
                .stroke(AppColors.gray, style: .init(lineWidth: 1))
        }
       
    }
}

#Preview {
    SearchBar()
}
