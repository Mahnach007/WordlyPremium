//
//  FlashcardPackView.swift
//  WordlyPremium
//
//  Created by Diego Arroyo on 17/03/25.
//

import SwiftUI

struct PackView: View {
    @Environment(\.dismiss) var dismiss
    @State var pack: PackEntity?
    @State var progress: CGFloat = 0.0
    @State var progressPercentage: Int = 0

    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                if let pack = pack {
                    VStack(spacing: 25) {
                        VStack(alignment: .leading) {
                            Text(pack.name)
                                .font(.custom("Feather", size: 24))
                        }
                        ZStack {
                            ProgressCircular(
                                progress: pack.studiedPercentage
                            )
                            .frame(width: 155, height: 155)
                            .padding()
                            Text(
                                String(
                                    format: "%.0f", pack.studiedPercentage * 100
                                ) + "%"
                            )
                            .font(.custom("Feather", size: 36))
                            .padding()
                        }
                        HStack(spacing: 50) {
                            VStack {
                                Text("\(pack.notStudiedFlashcardsCount)")
                                    .font(.custom("Feather", size: 24))
                                Text("not studied")
                                    .font(.custom("Feather", size: 14))
                            }
                            VStack {
                                Text("\(pack.studiedFlashcardsCount)")
                                    .font(.custom("Feather", size: 24))
                                Text("learned")
                                    .font(.custom("Feather", size: 14))
                            }
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 50)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.azure, lineWidth: 2)
                        )
                        VStack(spacing: -17) {
                            NavigationLink(
                                destination: FlashcardPlayView(
                                    flashCards: pack.flashcards)
                            ) {
                                CardButtonExtended(
                                    cardTitle: "Flashcards", icon: "flashcards",
                                    isGradient: false, hasIcon: true,
                                    color: Color.azure
                                )
                            }
                            .buttonStyle(PlainButtonStyle())
                            CardButtonExtended(
                                cardTitle: "Learn", icon: "brain",
                                isGradient: false, hasIcon: true,
                                color: Color.azure
                            )
                            CardButtonExtended(
                                cardTitle: "Test", icon: "book",
                                isGradient: false,
                                hasIcon: true, color: Color.azure
                            )
                        }
                        VStack(alignment: .leading) {
                            HStack {
                                Text("\(pack.flashcardCount) cards")
                                Spacer()
                                Image(systemName: "line.3.horizontal.decrease")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30)
                                    .foregroundStyle(Color.azure)
                            }
                            .font(.custom("Feather", size: 18))
                            LazyVStack(alignment: .leading) {
                                ForEach(pack.flashcards.indices, id: \.self) {
                                    index in
                                    VStack(alignment: .leading) {
                                        HStack {
                                            VStack(
                                                alignment: .leading, spacing: 5
                                            ) {
                                                Text(
                                                    pack.flashcards[index]
                                                        .question
                                                )
                                                .font(
                                                    .custom("Feather", size: 22)
                                                )
                                                .foregroundStyle(Color.eel)
                                                ProgressBar(
                                                    progress: pack.flashcards[
                                                        index
                                                    ].isStudied == true ? 1 : 0)
                                                Text(
                                                    pack.flashcards[index]
                                                        .answer
                                                )
                                                .font(
                                                    .custom("Feather", size: 20)
                                                )
                                                .foregroundStyle(Color.rhino)
                                            }
                                            Spacer()
                                                .frame(width: 20)
                                            Image(
                                                systemName:
                                                    "speaker.wave.2.fill"
                                            )
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 30)
                                            .foregroundStyle(Color.azure)
                                        }
                                        .padding(.horizontal, 30)
                                        .padding(.top, index == 0 ? 15 : 0)
                                        .padding(
                                            .bottom,
                                            index == pack.flashcards.count - 1
                                                ? 15 : 0)
                                        if index != pack.flashcards.count - 1 {
                                            Rectangle()
                                                .foregroundStyle(Color.rhino)
                                                .frame(height: 1)
                                        }
                                    }
                                }
                            }
                            .background(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.rhino, lineWidth: 2)
                            )
                        }
                    }
                    .padding(20)
                } else {
                    Text("Loading...")
                        .font(.custom("Feather", size: 34))
                }
            }
            .font(.custom("Feather", size: 12))
            .padding(.top)
            .frame(maxHeight: .infinity, alignment: .top)
            .background(Color.background)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        HStack {
                            Text(Image(systemName: "arrow.left"))
                        }
                    }
                }
                //                ToolbarItemGroup(placement: .topBarTrailing) {
                //                    Button(action: {
                //
                //                    }) {
                //                        Image("link")
                //                    }
                //                    Button(action: {
                //
                //                    }) {
                //                        HStack {
                //                            Text(Image(systemName: "ellipsis"))
                //                        }
                //                    }
                //                }
            }
            .fontWeight(.bold)
            .foregroundStyle(Color.eel)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .regainSwipeBack()
        }
    }
}

//#Preview {
//    @StateObject var packViewModel = AddPackViewModel()
//    var packs = packViewModel.packs
//    var pack1 = packs[0]
//    PackView(pack: pack1)
//}
