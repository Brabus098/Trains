//  LoadAnimationView.swift

import SwiftUI

struct LoadAnimationView: View {
    
    // MARK: - Properties
    
    @State private var startAnimation = false
    let newText: String
    
    // MARK: - Body

    var body: some View {
        VStack {
            plainImage
            text
        }
    }
    
    // MARK: - Subviews

    private var plainImage: some View {
        Image("plain")
            .resizable()
            .frame(width: 100, height: 100)
            .rotationEffect(.degrees(270))
            .scaleEffect(startAnimation ?  0.7 : 1.3)
            .animation(
                        .easeInOut(duration: 2)
                        .repeatForever(autoreverses: true),
                               value: startAnimation
                           )
    }
    
    private var text: some View {
        Text(newText)
            .font(.custom("SFPro-Bold", size: 24))
            .multilineTextAlignment(.center)
            .foregroundColor(startAnimation ? .black : .blueUniversal)
            .animation(
                .linear(duration: 2)
                .repeatForever(autoreverses: true),
                value: startAnimation)
            .onAppear {
                startAnimation = true
            }
    }
}
