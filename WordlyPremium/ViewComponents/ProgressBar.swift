//
//  ProgressBar.swift
//  WordlyPremium
//
//  Created by Vlad Gotovchykov on 13/03/25.
//

import SwiftUI

struct ProgressBar: View {
    var progress: CGFloat // Passed from parent, value between 0 and 1
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // Background bar
                RoundedRectangle(cornerRadius: 10)
                    .fill(.shadow(.inner(radius: 3)))
                    .frame(height: 10)
                    .foregroundStyle(Color.gray)
                
                // Foreground bar (progress)
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.yellow)
                    .frame(width: max(progress, 0) * geometry.size.width, height: 10)
                
                // Inner highlight
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gold)
                    .frame(width: max(progress, 0) * geometry.size.width - 6 , height: 2.5)
                    .padding(.horizontal,3)
                    .padding(.bottom, 4)// Slight offset for inner bar
            }
        }
        .frame(height: 10) // Fix height externally
        .padding(.horizontal) // Control padding externally
    }
}


#Preview {
    ProgressBar(progress: 0.09)
}
