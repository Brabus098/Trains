//  SplashAnimationView.swift

import SwiftUI

struct SplashAnimationView: View {

    // MARK: - Properties

    @State private var animation: SplashAnimation = .start
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            Image("SplashScreen")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            Image("plain")
                .resizable()
                .frame(width: 150, height: 150)
                .rotationEffect(.degrees(270))
                .opacity(animation.opacity)
                .offset(y: animation.offset)
        }
        .onAppear {
            withAnimation(animation.animationType) {
                animation = .mid
            }
        }
    }
}
