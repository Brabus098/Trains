//  SettingsScreen.swift

import SwiftUI

struct SettingsScreenView: View {
    @Environment(ThemeManager.self) var themeManager
    @State var navigationPath: NavigationPath = NavigationPath()
    @Binding var hideTabBar: Bool
    
    var body: some View {
        @Bindable var themeManager = themeManager
        
        NavigationStack(path: $navigationPath) {
            ZStack {
                Color.background
                    .ignoresSafeArea()
                VStack {
                    VStack(spacing: 30) {
                        HStack {
                            Text("Темная тема")
                                .font(.custom("SFPro-Regula", size: 17))
                            Spacer()
                            Toggle("", isOn: $themeManager.isDarkMode)
                        }
                        HStack {
                            Text("Пользовательское соглашение")
                                .font(.custom("SFPro-Regula", size: 17))
                            Spacer()
                            Button(action: {
                                navigationPath.append("UserAgreement")
                            }) {
                                Image("NextButton")
                            }
                        }
                    }
                    Spacer()
                    VStack(spacing: 10) {
                        Text("Приложение использует API «Яндекс.Расписания»")
                        Text("Версия 1.0 (beta)")
                    }
                    .font(.custom("SFPro-Regula", size: 12))
                    .padding(.bottom, 60)
                }
                .padding()
                .navigationDestination(for: String.self) { route in
                    if route == "UserAgreement" {
                        ZStack {
                            Color.background
                                .ignoresSafeArea()
                            VStack{
                                CustomNavigation(title: "Информация о компании") {
                                    navigationPath.removeLast()
                                }
                                .background(Color.background)
                                UserAgreementView(hideTabBar: $hideTabBar)
                            }
                                .navigationBarHidden(true)
                        }
                    }
                }
            }
            .background(Color.background)
        }
        .onChange(of: navigationPath) { oldValue, newValue in
            withAnimation(.easeInOut(duration: 0.25)) {
                hideTabBar = !newValue.isEmpty
            }
        }
    }
}
