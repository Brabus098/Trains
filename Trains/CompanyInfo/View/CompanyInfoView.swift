//  CompanyInfoView.swift

import SwiftUI

struct CompanyInfoView: View {
    
    let info: CompanyInfoModel

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
            Image(info.bigLogoName)
                .resizable()
                .scaledToFit()
        }
    }
    
    private var companyName: some View {
        VStack(alignment: .leading) {
            Text(info.fullCompanyName)
                .font(.custom("SFPro-Bold", size: 24))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
    
    private var contactDetail: some View {
        VStack(alignment: .leading) {
           
            Text("E-mail")
                .font(.custom("SFPro-Regular", size: 17))

            Text(info.email)
                .font(.custom("SFPro-Regular", size: 12))
                .foregroundColor(.blueUniversal)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom)

            Text("Телефон")
                .font(.custom("SFPro-Regular", size: 17))

            Text(info.phone)
                .font(.custom("SFPro-Regular", size: 12))
                .foregroundColor(.blueUniversal)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
}
