//  ChooseStation.swift

import SwiftUI

struct ChooseStation: View {
    
    @Binding var hideTabBar: Bool
    var viewModel: ChooseCityViewModel
    @Binding var navigationPath: NavigationPath
    @State private var searchText: String = ""
    
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
                        viewModel.filterStation(by: newValue)
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
                    if let stationList = viewModel.stationList {
                        List(stationList, id: \.self) { station in
                            StationRow(navigationPath: $navigationPath, station: station, viewModel: viewModel)
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color.background)
                                .padding(.vertical, 7)
                        }
                        .scrollContentBackground(.hidden)
                        .listStyle(PlainListStyle())
                        .padding(.top, -10)
                        .scrollContentBackground(.hidden)
                        .opacity(viewModel.listIsEmpty ? 0 : 1)
                    } else {
                        Text("Data has no addede")
                    }
                    VStack {
                        Spacer()
                        Text("Станция не найдена")
                            .font(.custom("SFPro-Bold", size: 24))
                            .opacity(viewModel.listIsEmpty ? 1 : 0)
                        Spacer()
                        Spacer()
                    }
                }
            }
            .padding(.top, -10)
        }
    }
}

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
