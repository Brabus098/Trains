//  ChooseTimeView.swift

import SwiftUI

struct ChooseTimeView: View {
    
    @Bindable var viewModel: FiltersViewModel
    let timeOfDay: TimeOfDayType
    @State var imageState: String = "OffCheckBox"
    
    var body: some View {
        switch timeOfDay {
        case .morning:
            createTimeButton(text: "Утро 06:00 - 12:00",
                             viewModel: viewModel,
                             buttonStatus: viewModel.morningButtonState.status,
                             timeOfDay: .morning)
        case .day:
            createTimeButton(text: "День 12:00 - 18:00",
                             viewModel: viewModel,
                             buttonStatus: viewModel.dayButtonState.status,
                             timeOfDay: .day)
            
        case .afternoon:
            createTimeButton(text: "Вечер 18:00 - 00:00",
                             viewModel: viewModel,
                             buttonStatus: viewModel.afternoonButtonState.status,
                             timeOfDay: .afternoon)
            
        case .night:
            createTimeButton(text: "Ночь 00:00 - 06:00",
                             viewModel: viewModel,
                             buttonStatus: viewModel.nightButtonState.status,
                             timeOfDay: .night)
        case .none:
            Text("Данных нету")
        }
    }
    
    private func createTimeButton(text: String, viewModel: FiltersViewModel, buttonStatus: Bool, timeOfDay: TimeOfDayType) -> some View {
        HStack {
            Text(text)
                .font(.custom("SFPro-Regula", size: 17))
            Spacer()
            ImageStateView(viewModel: viewModel,
                           isOn: buttonStatus,
                           timeOfDay: timeOfDay)
        }
    }
}

