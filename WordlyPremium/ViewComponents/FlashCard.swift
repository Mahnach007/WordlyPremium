import SwiftUI
import AVFoundation

struct FlashCard: View {
    // Card content
    var question: String
    var answer: String
    
    // Animation states
    @State private var frontDegree: Double = 0.0
    @State private var backDegree: Double = -90.0
    @State private var isFlipped: Bool = false
    
    // Change to @Binding to receive color from parent view
    @Binding var borderColor: Color
    
    // Speech callback from parent instead of local ViewModel
    var onSpeak: (String, LanguageType) -> Void
    
    let durationAndDelay: CGFloat = 0.2
    
    var body: some View {
        ZStack {
            BackPart(
                answer: answer,
                degree: $backDegree,
                action: { speakPressed(isAnswer: true) },
                isFlipped: $isFlipped,
                borderColor: $borderColor
            )
            FrontPart(
                question: question,
                degree: $frontDegree,
                action: { speakPressed(isAnswer: false) },
                isFlipped: $isFlipped,
                borderColor: $borderColor
            )
        }
        .onTapGesture {
            flipCard()
        }
    }
    
    // Delegate speech to parent via callback
    private func speakPressed(isAnswer: Bool) {
        onSpeak(isAnswer ? answer : question, isAnswer ? .english : .italian)
    }
    
    func flipCard() {
        isFlipped.toggle()
        
        if isFlipped {
            withAnimation(.linear(duration: durationAndDelay)) {
                frontDegree = 90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)) {
                backDegree = 0
            }
        } else {
            withAnimation(.linear(duration: durationAndDelay)) {
                backDegree = -90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)) {
                frontDegree = 0
            }
        }
    }
}

struct FrontPart: View {
    var question: String
    
    @Binding var degree: Double
    
    let action: () -> Void
    
    @Binding var isFlipped: Bool
    @Binding var borderColor: Color
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Create a container that will hold both shadow and card
                // with proper padding for the border
                RoundedRectangle(cornerRadius: 23)
                .strokeBorder(borderColor, lineWidth: 5)
                    .shadow(color: borderColor.opacity(0.9), radius: 5, x: 0, y: 0)
                    .shadow(color: borderColor.opacity(0.7), radius: 10, x: 0, y: 0)
                    .shadow(color: borderColor.opacity(0.5), radius: 15, x: 0, y: 0)
                    .shadow(color: borderColor.opacity(0.3), radius: 20, x: 0, y: 0)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                
                ZStack {
                    // Shadow card
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(Color.darkBlue)
                        .offset(y: 7)

                    // Main card
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(Color.lightBlue)
                        .overlay(alignment: .topLeading) {
                            Button {
                                action()
                            } label: {
                                Image(systemName: "speaker.wave.2.fill")
                                    .font(.system(size: 25))
                                    .foregroundStyle(Color.white)
                                    .padding(.top, 28)
                                    .padding(.horizontal, 21)
                            }
                        }
                        .overlay {
                            // Decorative elements
                            RoundedRectangle(cornerRadius: 1)
                                .frame(width: 1000, height: 120)
                                .foregroundStyle(Color.white.opacity(0.3))
                                .rotationEffect(.degrees(-35))
                                .offset(x: 0, y: 250)

                            RoundedRectangle(cornerRadius: 1)
                                .frame(height: 100)
                                .foregroundStyle(Color.white.opacity(0.3))
                                .rotationEffect(.degrees(-35))
                                .offset(x: 70, y: 420)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    // Text content
                    Text(question)
                        .font(.custom("feather", size: 38))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .lineLimit(4)
                        .minimumScaleFactor(0.5)
                        .padding(20)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(width: max(geometry.size.width - 6, 0), height: max(geometry.size.height - 6, 0))
            }
            .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
        }
        .padding()
    }
}

struct BackPart: View {
    var answer: String
    
    @Binding var degree: Double
    
    // Speech view model - passed from parent
    let action: () -> Void
    
    // Card state
    @Binding var isFlipped: Bool
    @Binding var borderColor: Color
    
    var body: some View {
        GeometryReader { geometry in
            
            ZStack {
                RoundedRectangle(cornerRadius: 23)
                .strokeBorder(borderColor, lineWidth: 5)
                    .shadow(color: borderColor.opacity(0.9), radius: 5, x: 0, y: 0)
                    .shadow(color: borderColor.opacity(0.7), radius: 10, x: 0, y: 0)
                    .shadow(color: borderColor.opacity(0.5), radius: 15, x: 0, y: 0)
                    .shadow(color: borderColor.opacity(0.3), radius: 20, x: 0, y: 0)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                
                ZStack {
                    // Shadow card
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(Color.lightBlue)
                        .offset(y: 7)
                    
                    // Main card
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(Color.darkBlue)
                        .overlay(alignment: .topLeading) {
                            Button {
                                // Speak the answer in Italian
                                action()
                            } label: {
                                Image(systemName: "speaker.wave.2.fill")
                                    .font(.system(size: 25))
                                    .foregroundStyle(Color.white)
                                    .padding(.top, 28)
                                    .padding(.horizontal, 21)
                            }
                        }
                        .overlay {
                            // Decorative elements
                            RoundedRectangle(cornerRadius: 1)
                                .frame(width: 1000, height: 120)
                                .foregroundStyle(Color.white.opacity(0.3))
                                .rotationEffect(.degrees(-35))
                                .offset(x: 0, y: 250)
                            
                            RoundedRectangle(cornerRadius: 1)
                                .frame(height: 100)
                                .foregroundStyle(Color.white.opacity(0.3))
                                .rotationEffect(.degrees(-35))
                                .offset(x: 70, y: 420)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    // Text content
                    Text(answer)
                        .font(.custom("feather", size: 38))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .lineLimit(4)
                        .minimumScaleFactor(0.5)
                        .padding(20)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(width: max(geometry.size.width - 6, 0), height: max(geometry.size.height - 6, 0))
            }
            .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
        }.padding()
    }
}


