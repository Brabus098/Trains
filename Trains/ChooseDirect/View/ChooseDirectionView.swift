//  ChooseDirectionView.swift

import SwiftUI

struct ChooseDirectionView: View {
    
    let mainViewHeight: CGFloat = 128
    var viewModel: ChooseCityViewModel
    
    @Binding var navigationPath: NavigationPath
    @Binding var activeDirection: DirectionType?
    
    @State private var topButtonTitle = "Откуда"
    @State private var bottomButtonTitle = "Куда"
    @State private var isSwapped = false
    
    var body: some View {
        ZStack {
            HStack(spacing: 22) {
                Spacer()
                VStack(spacing: 0) {
                    originButton
                    destinationButton
                }
                .frame(height: mainViewHeight * 0.8)
                .frame(maxWidth: .infinity)
                .background(.white)
                .cornerRadius(20)
                
                // Кнопка свапа
                Button(action: {
                    viewModel.swapDirections()
                    isSwapped.toggle()
                }) {
                    Image("ChangeImage")
                        .resizable()
                        .frame(width: 36, height: 36)
                }
                Spacer()
            }
            .frame(maxHeight: mainViewHeight)
            .frame(maxWidth: .infinity)
            .background(.blueUniversal)
            .cornerRadius(20)
            .padding()
        }
        .onChange(of: viewModel.finalDirectionFrom) { oldValue, newValue in
            
            if let newCity = newValue {
                topButtonTitle = newCity
            } else {
                topButtonTitle = "Откуда"
            }
        }
        .onChange(of: viewModel.finalDirectionTo) { oldValue, newValue in
            
            if let newCity = newValue {
                bottomButtonTitle = newCity
            } else {
                bottomButtonTitle = "Куда"
            }
        }
    }
    
    private var originButton: some View {
        Button(action: {
            viewModel.needCityArray()
            activeDirection = .from
            navigationPath.append(DirectionType.from)
        }) {
            // Верхняя кнопка всегда показывает FROM направление
            if topButtonTitle == "Откуда" {
                Text("Откуда")
                    .font(.custom("SFPro-Regular", size: 17))
                    .foregroundColor(.grayUniversal)
                    .frame(maxWidth: .infinity, alignment: .leading)
            } else {
                Text(topButtonTitle)
                    .font(.custom("SFPro-Regular", size: 17))
                    .foregroundColor(.blackUniversal)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(.leading, 16)
        .padding(.vertical, 12)
        .background(Color.white)
        .contentShape(Rectangle())
    }
    
    private var destinationButton: some View {
        Button(action: {
            viewModel.needCityArray()
            activeDirection = .to
            navigationPath.append(DirectionType.to)
        }) {
            // Нижняя кнопка всегда показывает TO направление
            if bottomButtonTitle == "Куда" {
                Text("Куда")
                    .font(.custom("SFPro-Regular", size: 17))
                    .foregroundColor(.grayUniversal)
                    .frame(maxWidth: .infinity, alignment: .leading)
            } else {
                Text(bottomButtonTitle)
                    .font(.custom("SFPro-Regular", size: 17))
                    .foregroundColor(.blackUniversal)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(.leading, 16)
        .padding(.vertical, 13)
        .background(Color.white)
        .contentShape(Rectangle())
    }
}
