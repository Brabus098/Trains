//  ContentView.swift

import SwiftUI

struct ContentView: View {

    @State private var showSplash = true

    var body: some View {
        ZStack {
            CustomTabView()
                .zIndex(0)

            if showSplash {
                SplashAnimationView()
                    .transition(.opacity)
                    .zIndex(1)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                withAnimation(.easeOut(duration: 0.5)) {
                    showSplash = false
                }
            }
        }
    }
}
