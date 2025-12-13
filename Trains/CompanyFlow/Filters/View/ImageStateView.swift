//  ImageStateView.swift

import SwiftUI

struct ImageStateView: View {
    
    @Bindable var viewModel: FiltersViewModel
    let isOn: Bool
    let timeOfDay: TimeOfDayType
    
    var body: some View {
        VStack {
            isOn ? Image("CheckBoxOn") :  Image("OffCheckBox")
        }
        .onTapGesture {
            switch timeOfDay {
            case .morning:
                viewModel.morningButtonState.status
                    .toggle()
            case .day:
                viewModel.dayButtonState.status.toggle()
            case .afternoon:
                viewModel.afternoonButtonState.status.toggle()
            case .night:
                viewModel.nightButtonState.status.toggle()
            case .none:
                print("[ImageStateView]: неизвествный статус)")
            }
            viewModel.checkAllStatesAdded()
        }
    }
}
