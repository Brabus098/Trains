//  CompanyList.swift

import SwiftUI

struct CompanyList: View {
    
    @Bindable var viewModel: CompanyListViewModel
    @Binding var navigationPath: NavigationPath
    
    let directionTo: SelectedDirection
    let directionFrom: SelectedDirection
    let columns = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        ZStack {
            VStack {
                Text("\(directionFrom.city) (\(directionFrom.trainStations)) →  \(directionTo.city) (\(directionTo.trainStations))")
                    .font(.custom("SFPro-Bold", size: 24))
                    .padding()
                ScrollView {
                    LazyVGrid(columns: columns) {
                        if let companiesList = viewModel.filterCompanies,  companiesList.count > 0 {
                            ForEach(companiesList) { companies in
                                CompanyCellView(navigationPath: $navigationPath, image: companies.image,
                                                nameOfCompany: companies.companyName,
                                                needSwapStation: companies.needSwapStation,
                                                swapStation: companies.swapStation,
                                                date: companies.date,
                                                allTimePath: companies.allTimePath,
                                                timeToStart: companies.timeToStart,
                                                timeToOver: companies.timeToOver)
                                .padding(.horizontal)
                            }
                        }
                        Color.clear
                            .frame(height: 100)
                    }
                }
                .scrollIndicators(.hidden)
            }
            
            if let companies = viewModel.filterCompanies, companies.isEmpty {
                VStack {
                    Spacer()
                    Text("Вариантов нет")
                        .font(.custom("SFPro-Bold", size: 24))
                    Spacer()
                }
            }
            
            VStack {
                Spacer()
                Button(action: {
                    navigationPath.append("FilterScreen")
                }) {
                    HStack {
                        Text("Уточнить время")
                            .font(.custom("SFPro-Bold", size: 17))
                        if viewModel.visibleButtonStatus {
                            Image("Counter")
                            
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 60)
                }
                .foregroundColor(.white)
                .background(.blueUniversal)
                .cornerRadius(16)
                .padding(.horizontal)
                .padding(.vertical, 5)
            }
        }
        .onAppear {
            if viewModel.companies == nil {
                viewModel.getCompany(from: directionFrom, to: directionTo)
            }
        }
    }
}

struct CompanyCellView : View {
    
    @Binding var navigationPath: NavigationPath
    
    let image: String
    let nameOfCompany: String
    let needSwapStation: Bool
    let swapStation: String?
    let date: String
    let allTimePath: String
    let timeToStart: String
    let timeToOver: String
    
    var body: some View {
        VStack {
            HStack {
                Image(image)
                    .frame(width:38, height: 38)
                VStack {
                    HStack {
                        Text(nameOfCompany)
                            .font(.custom("SFPro-Regula", size: 17))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(date)
                            .font(.custom("SFPro-Regula", size: 12))
                    }
                    .foregroundColor(.blackUniversal)
                    
                    if needSwapStation && swapStation != nil {
                        Text("C пересадкой в " + (swapStation ?? ""))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(.red)
                            .font(.custom("SFPro-Regula", size: 12))
                    } else {
                        EmptyView()
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 12)
            .padding(.bottom, 4)
            HStack {
                Text(timeToStart)
                    .font(.custom("SFPro-Regula", size: 17))
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 1)
                Text(allTimePath)
                    .font(.custom("SFPro-Regula", size: 12))
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 1)
                Text(timeToOver)
                    .font(.custom("SFPro-Regula", size: 17))
            }
            .foregroundColor(.blackUniversal)
            .padding(.horizontal)
            .padding(.top, 4)
            .padding(.bottom, 12)
        }
        .background(.lightGray)
        .cornerRadius(24)
        .onTapGesture {
            navigationPath.append("CompanyDetail")
        }
    }
}

//#Preview {
//    @Previewable @State var navigationPath = NavigationPath()
//    FilterForDirection(navigationPath: $navigationPath, viewModel: CompanyListViewModel())
//}


