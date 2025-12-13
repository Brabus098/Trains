//  SettingsScreen.swift

import SwiftUI

struct SettingsScreenView: View {
    @Environment(ThemeManager.self) var themeManager
    
    @State private var navigationPath: NavigationPath = NavigationPath()
    @Binding var hideTabBar: Bool
    @State var viewModel = SettingsViewModel(model: UserAgreementModel())
    
    var body: some View {
        
        NavigationStack(path: $navigationPath) {
            ZStack {
                Color.background
                    .ignoresSafeArea()
                VStack {
                    settings
                    Spacer()
                    footer
                }
                .padding()
                .navigationDestination(for: String.self) { route in
                    if route == "UserAgreement" {
                        ZStack {
                            Color.background
                                .ignoresSafeArea()
                            VStack{
                                CustomNavigation(title: "Пользовательское соглашение") {
                                    navigationPath.removeLast()
                                }
                                .background(Color.background)
                                UserAgreementView(hideTabBar: $hideTabBar, viewModel: viewModel)
                            }
                                .navigationBarHidden(true)
                        }
                    }
                }
            }
            .background(Color.background)
        }
        .onChange(of: navigationPath) { _, newValue in
            withAnimation(.easeInOut(duration: 0.25)) {
                hideTabBar = !newValue.isEmpty
            }
        }
    }
    
    private var footer: some View {
        VStack(spacing: 10) {
            Text(viewModel.userAgreement.nameOfApi)
            Text(viewModel.userAgreement.version)
        }
        .font(.custom("SFPro-Regula", size: 12))
        .padding(.bottom, 60)
    }
    
    private var settings: some View {
        @Bindable var themeManager = themeManager

        return VStack(spacing: 30) {
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
    }
}
