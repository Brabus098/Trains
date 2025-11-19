//  SettingsScreen.swift

import SwiftUI

struct SettingsScreen: View {
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
//            Text("Экран настроек")
//                .font(.custom("SFPro-Bold", size: 17))
            ErrorView(imageName: "NoInternetError", text: "Нет интернета")
//            ErrorView(imageName: "ServerError", text: "Ошибка сервера")
        }
    }
}
