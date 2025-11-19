//  ChooseTime.swift

import SwiftUI

struct ChooseTime: View {
    @Bindable var viewModel: CompanyListViewModel
    let timeOfDay: TimeOfDay
    @State var imageState: String = "OffCheckBox"
    
    var body: some View {
        switch timeOfDay {
        case .morning:
            HStack {
                Text("Утро 06:00 - 12:00")
                    .font(.custom("SFPro-Regula", size: 17))
                Spacer()
                ImageState(viewModel: viewModel, isOn: viewModel.morningButtonState.status, timeOfDay: .morning)
            }
        case .day:
            HStack {
                Text("День 12:00 - 18:00")
                    .font(.custom("SFPro-Regula", size: 17))
                Spacer()
                ImageState(viewModel: viewModel, isOn: viewModel.dayButtonState.status, timeOfDay: .day)
                
            }
        case .afternoon:
            HStack {
                Text("Вечер 18:00 - 00:00")
                    .font(.custom("SFPro-Regula", size: 17))
                Spacer()
                ImageState(viewModel: viewModel, isOn: viewModel.afternoonButtonState.status, timeOfDay: .afternoon)
            }
        case .night:
            HStack {
                Text("Ночь 00:00 - 06:00")
                    .font(.custom("SFPro-Regula", size: 17))
                Spacer()
                ImageState(viewModel: viewModel, isOn: viewModel.nightButtonState.status, timeOfDay: .night)
            }
        case .none:
            Text("Данных нету")
        }
    }
}

struct ImageState:View {
    @Bindable var viewModel: CompanyListViewModel
    let isOn: Bool
    let timeOfDay: TimeOfDay
    
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
                Text("Данных нету")
            }
            viewModel.checkAllStatesAdded()
        }
    }
}
