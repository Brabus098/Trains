//  CompanyList.swift

import SwiftUI

struct CompanyListView: View {
    
    @Bindable var viewModel: CompanyListViewModel
    @Binding var navigationPath: NavigationPath
    
    let columns = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            VStack {
                directionText
                companiesGrid
            }
            fallbackView
            searchButton
        }
        .task {
            if viewModel.filterCompanies == nil {
                await viewModel.getCompany(and: false)
            }
        }
    }
    
    private var directionText: some View {
        if let to = viewModel.to,
            let from = viewModel.from {
           return Text("\(from.city) (\(from.trainStations)) →  \(to.city) (\(to.trainStations))")
                .font(.custom("SFPro-Bold", size: 24))
                .padding()
        } else {
            return Text("Не удалось загрузить направление")
                .font(.custom("SFPro-Bold", size: 24))
                .padding()
        }
        
    }
    
    private var companiesGrid: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                if let companiesList =
                    viewModel.filterCompanies,companiesList.count > 0 {
                    ForEach(companiesList) { companies in
                        CompanyCellView(navigationPath: $navigationPath, viewModel: viewModel, companyModel: companies)
                            .padding(.horizontal)
                    }
                }
                Color.clear
                    .frame(height: 100)
            }
        }
        .scrollIndicators(.hidden)
    }
    
    private var searchButton: some View {
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
    
    private var fallbackView: some View {
        ZStack {
            Color.clear
            
            if let companiesList = viewModel.filterCompanies, companiesList.isEmpty {
                VStack {
                    Spacer()
                    Text("Вариантов нет")
                        .font(.custom("SFPro-Bold", size: 24))
                    Spacer()
                }
            }
        }
    }
}


