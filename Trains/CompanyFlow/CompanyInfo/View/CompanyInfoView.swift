//  CompanyInfoView.swift

import SwiftUI

struct CompanyInfoView: View {
    
    var viewModel: CompanyInfoViewModel
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            VStack {
                logo
                companyName
                contactDetail
                Spacer()
            }
        }
    }
    
    private var logo: some View {
        VStack {
            if let bigLogo = viewModel.infoCompany?.bigLogoName{
                Image(bigLogo)
                    .resizable()
                    .scaledToFit()
            }
        }
    }
    
    private var companyName: some View {
        VStack(alignment: .leading) {
            if let fullCompanyName = viewModel.infoCompany?.fullCompanyName{
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
                Text(email)
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
