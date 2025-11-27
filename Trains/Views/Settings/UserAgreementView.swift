//  UserAgreementView.swift

import SwiftUI

struct UserAgreementView:View {
    @Binding var hideTabBar: Bool
    
    var body: some View {
        VStack {
            Text(verbatim: .namesOffer)
                .font(.custom("SFPro-Bold", size: 24))
            ScrollView {
                Text(verbatim: .linkOfDocument)
                    .font(.custom("SFPro-Regula", size: 17))
                Text("1. ТЕРМИНЫ")
                    .font(.custom("SFPro-Bold", size: 24))
                    .multilineTextAlignment(.leading)
                Text(verbatim: .textDocument)
                .font(.custom("SFPro-Regula", size: 17))
            }
            .multilineTextAlignment(.leading)
            .padding()
        }
    }
}
