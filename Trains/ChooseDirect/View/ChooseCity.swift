//  ChooseCity.swift

import SwiftUI

struct ChooseCity: View {
    
    @Binding var hideTabBar: Bool
    @Binding var navigationPath: NavigationPath
    
    @State private var searchText: String = ""

    var viewModel: ChooseCityViewModel
    var directionType: DirectionType
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Image(searchText.isEmpty ?  "SearchBarFirst" : "SearchBarSecond")
                    TextField("",
                              text: $searchText,
                              prompt: Text("Введите запрос")
                    )
                    .textFieldStyle(.plain)
                    .foregroundStyle(.text)
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
                    .onChange(of: searchText) { oldValue, newValue in
                        viewModel.filterCity(by: newValue)
                    }
                    Image("CancelButton")
                        .onTapGesture {
                            searchText = ""
                        }
                        .opacity(searchText.isEmpty ? 0 : 1)
                }
                .padding(.horizontal, 12)
                .background(.backForTextField)
                .frame(height: 36)
                .cornerRadius(10)
                .padding()
                Spacer().frame(height: 12)
                ZStack {
                    if let cityList = viewModel.cityList {
                        List(cityList, id: \.self) { city in
                            CityRow( navigationPath: $navigationPath,
                                     place: city,
                                     viewModel: viewModel)
                            .listRowBackground(Color.background)
                            .padding(.vertical, 7)
                        }
                        .onAppear {
                            viewModel.directionType = directionType
                        }
                        .listStyle(PlainListStyle())
                        .padding(.top, -8)
                        .scrollContentBackground(.hidden)
                        .background(Color.background)
                        .opacity(viewModel.listIsEmpty ? 0 : 1)
                    } else {
                        Text("Data has no addede")
                    }
                    VStack {
                        Spacer()
                        Text("Город не найден")
                            .font(.custom("SFPro-Bold", size: 24))
                            .opacity(viewModel.listIsEmpty ? 1 : 0)
                        Spacer()
                        Spacer()
                    }
                }
            }
            .padding(.top, -11)
        }
    }
}

struct CityRow: View {
    
    @Binding var navigationPath: NavigationPath
    let place: String
    var viewModel: ChooseCityViewModel
    
    var body: some View {
        HStack() {
            Text(place)
            Spacer()
            Button(action: {
                viewModel.selectedCity = place
                viewModel.needStationForCity()
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
