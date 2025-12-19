//  SplashAnimationView.swift

import SwiftUI

struct SplashAnimationView: View {

    @State private var animation: SplashAnimation = .start

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
