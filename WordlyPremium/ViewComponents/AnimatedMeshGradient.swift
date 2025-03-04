////
////  AnimatedMeshGradient.swift
////  WordlyPremium
////
////  Created by Ulugbek Abdimurodov on 04/03/25.
////
//
//import SwiftUI
//
//struct AnimatedMeshGradient: View {
//    @State private var inputText = ""
//    @State private var isLoading = false
//    
//    var body: some View {
//        
//        ZStack {
//            Color(.systemGray6).edgesIgnoringSafeArea(.all)
//            
//            VStack(spacing: 20) {
//                Text("Generate Notes")
//                    .font(.title)
//                    .fontWeight(.bold)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                
//                Text("Tranfsorm your thoughts into well-styled notes using artificial intelligence.")
//                    .font(.subheadline)
//                    .foregroundColor(.secondary)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                
//                TextEditor(text: $inputText)
//                    .frame(height: 200)
//                    .padding()
//                    .background(
//                        RoundedRectangle(cornerRadius: 16)
//                            .fill(Color(.systemBackground))
//                            .shadow(color: .black.opacity(0.05), radius: 15, x: 0, y: 5)
//                    )
//                
//                Button(action: {} ) {
//                    HStack {
//                        if isLoading {
//                            ProgressView()
//                                .tint(.white)
//                        } else {
//                            Image(systemName: "spark")
//                        }
//                        Text(isLoading ? "Generating ..." : "Generate Words")
//                    }
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .background(
//                        Meshgradient(width: 3, height: 3, points: [
//                            .init(0, 0), .init(0.5, 0), .init(1, 0),
//                            .init(0, 0.5), .init(0.5, 0.5), .init(1, 0.5),
//                            .init(0, 1), .init(0.5, 1), .init(1, 1)
//                        ], colors: [
//                            .blue, .purple, .indigo,
//                            .orange, .white, .blue,
//                            .yellow, .green, .mint
//                        ])
//                        .mask(
//                            RoundedRectangle(cornerRadius: 16)
//                                .stroke(lineWidth: 16)
//                                .blur(radius: 8)
//                        )
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 16)
//                                .stroke(.white, lineWidth: 2)
//                                .blur(radius: 2)
//                                .blendMode(.overlay)
//                        )
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 16)
//                                .stroke(.white, lineWidth: 2)
//                                .blur(radius: 1)
//                                .blendMode(.overlay)
//                        )
//                    )
//                    .background(.black)
//                }
//            }
//        }
//    }
//}
//
//struct AnimatedMeshGradient_Previews: PreviewProvider {
//    static var previews: some View {
//        AnimatedMeshGradient()
//    }
//}
