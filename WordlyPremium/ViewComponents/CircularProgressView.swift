//
//  CircularProgressView.swift
//  WordlyPremium
//
//  Created by Diego Arroyo on 17/03/25.
//

import SwiftUI

struct CircularProgressView: View {
  let progress: CGFloat

  var body: some View {
    ZStack {
      Circle()
        .stroke(lineWidth: 20)
        .foregroundColor(.eel)
      Circle()
            .trim(from: 0, to: min(progress, 1))
        .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
        .foregroundColor(.yellow)
        .rotationEffect(Angle(degrees: 270.0))
        .animation(.linear, value: progress)
    }
  }
}

#Preview {
    CircularProgressView(progress: 0.4)
}
