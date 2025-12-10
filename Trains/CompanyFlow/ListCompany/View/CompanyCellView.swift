//  CompanyCellView.swift

import SwiftUI

struct CompanyCellView : View {
    
    @Binding var navigationPath: NavigationPath
    let viewModel: CompanyListViewModel
    
    let companyModel: CompanyModel
    
    var body: some View {
        VStack {
            HStack {
                Image(companyModel.image)
                    .frame(width:38, height: 38)
                topLine
            }
            .padding(.horizontal)
            .padding(.top, 12)
            .padding(.bottom, 4)
            downLine
        }
        .background(.lightGray)
        .cornerRadius(24)
        .onTapGesture {
            viewModel.setSelectCompany(detail: companyModel)
            navigationPath.append("CompanyDetail")
        }
    }
    
    private var topLine: some View {
        VStack {
            HStack {
                Text(companyModel.companyName)
                    .font(.custom("SFPro-Regula", size: 17))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(companyModel.date)
                    .font(.custom("SFPro-Regula", size: 12))
            }
            .foregroundColor(.blackUniversal)
            
            if companyModel.needSwapStation && companyModel.swapStation != nil {
                Text("C пересадкой в " + (companyModel.swapStation ?? ""))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(.red)
                    .font(.custom("SFPro-Regula", size: 12))
            } else {
                EmptyView()
            }
        }
    }
    
    private var downLine: some View {
        HStack {
            Text(companyModel.timeToStart)
                .font(.custom("SFPro-Regula", size: 17))
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .frame(height: 1)
            Text(companyModel.allTimePath)
                .font(.custom("SFPro-Regula", size: 12))
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .frame(height: 1)
            Text(companyModel.timeToOver)
                .font(.custom("SFPro-Regula", size: 17))
        }
        .foregroundColor(.blackUniversal)
        .padding(.horizontal)
        .padding(.top, 4)
        .padding(.bottom, 12)
    }
}
