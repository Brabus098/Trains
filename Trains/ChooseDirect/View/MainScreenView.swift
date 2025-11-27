//  MainScreenView.swift

import SwiftUI

struct MainScreenView: View {
    @Environment(ThemeManager.self) var themeManager

    @Binding var hideTabBar: Bool
    
    @State private var navigationPath = NavigationPath()
    @State private var activeDirection: DirectionType? = nil
    @State var companyViewModel = CompanyListViewModel()
    @State var viewModel = ChooseCityViewModel()
    var storiesViewModel: StoriesViewModel
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                StoriesFeedView(hideTabBar: $hideTabBar, navigationPath: $navigationPath, viewModel: storiesViewModel)
                
                ChooseDirectionView(viewModel: viewModel, navigationPath: $navigationPath, activeDirection: $activeDirection)
                
                Button(action: {
                    companyViewModel = CompanyListViewModel()
                    navigationPath.append("CompanyList")
                }) {
                    Text("Найти")
                        .font(.custom("SFPro-Bold", size: 17))
                        .foregroundColor(.white)
                        .frame(maxWidth: 150, maxHeight: 60)
                        .background(.blueUniversal)
                        .cornerRadius(16)
                }
                .opacity(viewModel.allDirectionAdds ? 1 : 0)
                .disabled(!viewModel.allDirectionAdds)
                Spacer()
            }
            .navigationDestination(for: DirectionType.self) { direction in
                ZStack {
                    Color.background
                        .ignoresSafeArea()
                    
                    VStack(spacing: 0) {
                        CustomNavigation(title: "Выбор города") {
                            navigationPath.removeLast()
                        }
                        .background(Color.background)
                        
                        ChooseCityView(hideTabBar: $hideTabBar, navigationPath: $navigationPath,
                                   viewModel: viewModel,
                                   directionType: direction)
                        .navigationBarHidden(true)
                    }
                }
                .onAppear {
                    activeDirection = direction
                }
            }
            .navigationDestination(for: String.self) { route in
                if route == "SelectStation" {
                    ZStack {
                        Color.background
                            .ignoresSafeArea()
                        VStack(spacing: 0) {
                            CustomNavigation(title: "Выбор станции") {
                                navigationPath.removeLast()
                            }
                            .background(Color.background)
                            ChooseStationView(hideTabBar: $hideTabBar, viewModel: viewModel, navigationPath: $navigationPath)
                                .navigationBarHidden(true)
                        }
                    }
                }
                else if route == "CompanyList" {
                    if let from = viewModel.directionFrom, let to = viewModel.directionTo {
                        ZStack {
                            Color.background
                                .ignoresSafeArea()
                            VStack(spacing: 0) {
                                CustomNavigation(title: "") {
                                    navigationPath.removeLast()
                                }
                                .background(Color.background)
                                CompanyListView(viewModel: companyViewModel, navigationPath: $navigationPath, directionTo: to, directionFrom: from)
                                    .navigationBarHidden(true)
                            }
                        }
                    }
                } else if route == "FilterScreen" {
                    ZStack {
                        Color.background
                            .ignoresSafeArea()
                        VStack(spacing: 0) {
                            CustomNavigation(title: "") {
                                navigationPath.removeLast()
                            }
                            .background(Color.background)
                            FilterForDirection(navigationPath: $navigationPath, viewModel: companyViewModel)
                                .navigationBarHidden(true)
                        }
                    }
                } else if route == "CompanyDetail" {
                    ZStack {
                        Color.background
                            .ignoresSafeArea()
                        VStack(spacing: 0) {
                            CustomNavigation(title: "Пользовательское соглашение") {
                                navigationPath.removeLast()
                            }
                            .background(Color.background)
                            if let detail =  companyViewModel.selectedCompanyDetail?.detailInfo {
                                CompanyInfoView(info: CompanyInfoModel(bigLogo: detail.bigLogo,
                                                                       fullCompanyName: detail.fullCompanyName,
                                                                       email:detail.email,
                                                                       phone: detail.phone))
                                .navigationBarHidden(true)
                            } else {
                                Text("Нет информации о компании") .font(.custom("SFPro-Regula", size: 17))
                            }
                        }
                    }
                } else if route == "Stories" {
                    if let actualStory = storiesViewModel.actualStory {
                        StoryLentView(stories: actualStory, viewModel: storiesViewModel)
                            .navigationBarHidden(true)
                    } else {
                        Text("Нет информации о истории")
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
