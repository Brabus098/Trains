//  CustomNavigationStyle.swift

import SwiftUI

struct CustomNavigation: View {
    let title: String
    let backAction: () -> Void
    
    var body: some View {
        HStack {
            Button(action: backAction) {
                HStack {
                    Image("LeftChevron")
                        .padding(.horizontal, -25)
                }
                .frame(width: 30, height: 44)
            }
            
            Text(title)
                .font(.custom("SFPro-Bold", size: 17))
                .frame(maxWidth: .infinity)
                .lineLimit(1)
            
            Rectangle()
                .fill(Color.clear)
                .frame(width: 44, height: 44)
        }
        .padding(.horizontal)
        .frame(height: 44)
        .background(Color.background)
    }
}

