//
//  ProgressBar.swift
//  WordlyPremium
//
//  Created by Vlad Gotovchykov on 13/03/25.
//

import SwiftUI

struct ProgressBar: View {
    var progress: CGFloat

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.shadow(.inner(radius: 3)))
                    .frame(height: 10)
                    .foregroundStyle(Color.gray)
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.bee)
                    .fill(Color.bee)
                    .frame(
                        width: max(progress, 0) * geometry.size.width,
                        height: 10)
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.duck)
                    .frame(
                        width: max(progress, 0) * geometry.size.width - 6,
                        height: 2.5
                    )
                    .padding(.horizontal, 3)
                    .padding(.bottom, 4)
            }
        }
        .frame(height: 10)
    }
}

#Preview {
    ProgressBar(progress: 1.0)
}
