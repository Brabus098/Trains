//  SettingsScreen.swift

import SwiftUI

struct SettingsScreen: View {
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            Text("Экран настроек")
                .font(.custom("SFPro-Bold", size: 17))
        }
    }
}
