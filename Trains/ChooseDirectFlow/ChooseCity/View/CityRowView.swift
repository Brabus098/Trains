//  CityRowView.swift

import SwiftUI

struct CityRowView: View {
    
    @Binding var navigationPath: NavigationPath
    let place: String
    var viewModel: ChooseCityViewModel
    
    var body: some View {
        HStack() {
            Text(place)
            Spacer()
            Button(action: {
                viewModel.setSelectedCity(place)
                navigationPath.append("SelectStation")
            }) {
                Image("NextButton")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
        }
        .listRowSeparator(.hidden)
    }
}
