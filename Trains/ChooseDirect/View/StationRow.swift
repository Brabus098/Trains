//  StationRow.swift

import SwiftUI

struct StationRow: View {
    @Binding var navigationPath: NavigationPath
    
    let station: String
    var viewModel: ChooseCityViewModel
    
    var body: some View {
        HStack() {
            Text(station)
            Spacer()
            Button(action: {
                viewModel.selectedStation = station
                viewModel.containsDestinationIfCan()
                viewModel.activeIfAllAdds()
                navigationPath = NavigationPath()
            }) {
                Image("NextButton")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
        }
    }
}
