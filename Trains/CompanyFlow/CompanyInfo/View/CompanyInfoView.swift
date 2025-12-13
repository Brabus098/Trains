//  CompanyInfoView.swift

import SwiftUI

struct CompanyInfoView: View {
    
    // MARK: - Properties

    var viewModel: CompanyInfoViewModel
    var companyListViewModel: CompanyListViewModel
    
    // MARK: - Body

    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            contentView
        }
        .task {
            if let companyModel = viewModel.companyDetail {
                await companyListViewModel.setSelectCompany(detail: companyModel)
            }
        }
    }
    
    // MARK: - Subviews

    private var contentView: some View {
        VStack {
            if !companyListViewModel.needToShowAlert && !companyListViewModel.needToShowErrorView {
                VStack {
                    logo
                    companyName
                    contactDetail
                    Spacer()
                }
            } else if companyListViewModel.needToShowAlert {
                ErrorView(viewModel: ErrorViewModel(actualStatus: .NoInternetConnection))
            } else {
                ErrorView(viewModel: ErrorViewModel(actualStatus: .ServerError))
            }
        }
    }
    
    private var logo: some View {
        VStack {
            if let bigLogo = viewModel.infoCompany?.bigLogoName {
                ZStack {
                    Color.white
                        .frame(height: 100)
                        .cornerRadius(24)
                    AsyncImage(url: URL(string: bigLogo)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 100, alignment: .trailing)
                    } placeholder: {
                        Color.white
                    }
                }
                .frame(height: 100, alignment: .center)
                .cornerRadius(24)
                .padding(.top)
                .padding(.horizontal)
            }
        }
    }
    
    private var companyName: some View {
        VStack(alignment: .leading) {
            if let fullCompanyName = viewModel.infoCompany?.fullCompanyName {
                Text(fullCompanyName)
                    .font(.custom("SFPro-Bold", size: 24))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
    
    private var contactDetail: some View {
        VStack(alignment: .leading) {
            
            Text("E-mail")
                .font(.custom("SFPro-Regular", size: 17))
            if let email = viewModel.infoCompany?.email {
                VStack{
                    if email.isEmpty {
                        Text("cargo@email.ru")
                    } else {
                        Text(email)
                    }
                }
                .font(.custom("SFPro-Regular", size: 12))
                .foregroundColor(.blueUniversal)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom)
            }
            Text("Телефон")
                .font(.custom("SFPro-Regular", size: 17))
            
            if let phone = viewModel.infoCompany?.phone {
                Text(phone)
                    .font(.custom("SFPro-Regular", size: 12))
                    .foregroundColor(.blueUniversal)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
}
