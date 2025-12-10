//  StationRowView.swift

import SwiftUI

struct StationRowView: View {
    @Binding var navigationPath: NavigationPath
    
    let station: String
    var viewModel: ChooseStationViewModel
    
    var body: some View {
        HStack() {
            Text(station)
            Spacer()
            Button(action: {
                viewModel.setStation(with: station)
                viewModel.tryContainsDestination()
                viewModel.tryActiveIfAdds()
                navigationPath = NavigationPath()
            }) {
                Image("NextButton")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
        }
    }
}
