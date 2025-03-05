import SwiftUI

struct LanguageButton: View {
    var flagImage: String // SF Symbol or asset image name
    var languageName: String
    
    var body: some View {
        Button(action: {}) {
            HStack {
                Image(flagImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                
                Text(languageName)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.black)
                
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: Color.black.opacity(0.15), radius: 4, x: 0, y: 2)
        }
        .buttonStyle(PlainButtonStyle()) // Removes default button styling
    }
}

struct LanguageButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            LanguageButton(flagImage: "italy", languageName: "Italian")
        }
        .padding()
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}