//  LoadAnimationView.swift

import SwiftUI

struct LoadAnimationView: View {
    
    @State private var startAnimation = false
    
    var body: some View {
        VStack {
            plainImage
            text
        }
    }
    
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
        Text("Ищем варианты")
            .font(.custom("SFPro-Bold", size: 24))
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
