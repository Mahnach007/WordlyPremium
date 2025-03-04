//
//  Folder.swift
//  WordlyPremium
//
//  Created by Dilyorbek Sharofiddinov on 04/03/25.
//

import SwiftUI

struct Folders: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Car transport only nouns")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.black)
                
                Text("2 packs")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Image("folders-icon")
                .resizable()
                .scaledToFit()
                .frame(width: 45, height: 50)
                .clipped()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(Color.gray, lineWidth: 2),
            alignment: .top
        )
     
        .padding(.horizontal)
    }
}

#Preview {
    Folders()
}
