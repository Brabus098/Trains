//  ChooseStationModel.swift

struct ChooseStationModel {
    
    private let cityList = ChoosePlaceModel.mockCities
    
    func getStation(for city: String) -> [String] {
        let a = cityList.filter { $0.city == city }
        return a.flatMap { $0.trainStations }
    }
}

