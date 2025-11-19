//  NeedSwapTransport.swift

import SwiftUI

struct NeedSwapTransport: View {
    let isOn: Bool
    @Bindable var viewModel: CompanyListViewModel
    let needSwap: NeedSwap
    
    var body: some View {
        VStack{
            isOn ? Image("RadioButtonOn") : Image("RadioButtonOff")
        }
        .onTapGesture {
            if needSwap == .yes {
                viewModel.yesRadioButtonState.toggle()
                viewModel.noRadioButtonState = !viewModel.yesRadioButtonState
            } else {
                viewModel.noRadioButtonState.toggle()
                viewModel.yesRadioButtonState = !viewModel.noRadioButtonState
            }
            viewModel.checkAllStatesAdded()
        }
    }
}
