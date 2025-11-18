import SwiftUI

struct Stories: View {
    
    let height: CGFloat = 140
    let width: CGFloat = 92
    
    let imageName: String
    let textForImage = "Text Text Text Text Text Text Text Text Text"
    
    var body: some View {
        ZStack {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: width, height: height)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.blue, lineWidth: 4)
                )
            VStack{
                Text(textForImage)
                    .font(.custom("SFPro-Regular", size: 12))
                    .foregroundStyle(.white)
                    .frame(alignment: .bottom)
                    .frame(width: width * 0.8, height: height, alignment: .bottom)
                    .lineLimit(3)
                Spacer()
                Spacer()
            }
            .frame(width: width , height: height)
        }
    }
}
