//  ServerErrorView.swift

import SwiftUI

struct ErrorView: View {
    
    let imageHeight: CGFloat = 300
    let imageName: String
    let text: String
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: imageHeight, height: imageHeight)
                .padding()
            Text(text)
            .font(.custom("SFPro-Bold", size: 24))
        }
    }
}

#Preview {
    ErrorView(imageName: "NoInternetError", text: "Нет интернета")
}
