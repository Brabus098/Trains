//  ChooseCityViewModel.swift

import Foundation
import Observation

@Observable class ChooseCityViewModel {
    
    var selectedCity: String?
    var selectedStation: String?
    
    var directionFrom: SelectedDirection?
    var finalDirectionFrom: String?
    
    var finalDirectionTo: String?
    var directionTo: SelectedDirection?
    
    var directionType: DirectionType?
    
    var allDirectionAdds: Bool = false
    var listIsEmpty: Bool = false
    
    var stationList: [String]? // Данные  со станциями для конкретного города
    var cityList: [String]? // Данные из сети о выбранном городе
    
    var model: ChooseCityModel
    
    init() {
        self.model = ChooseCityModel()
    }
    
    func needCityArray() {
        cityList = model.getCityList()
        if let list = cityList, !list.isEmpty {
            listIsEmpty = false
        }
    }
    
    func needStationForCity() {
        guard let selectedCity else { return }
        stationList = model.getStation(for: selectedCity)
        if let stationList, !stationList.isEmpty {
            listIsEmpty = false
        }
    }
    
    func containsDestinationIfCan() {
        guard let city = selectedCity, let station = selectedStation, let direction = directionType else { return }
        
        
        if direction == .to {
            finalDirectionTo = city + "(" + station + ")"
            directionTo = SelectedDirection(city: city,
                                            trainStations: station,
                                            direction: .to)
            
        } else if direction == .from {
            finalDirectionFrom = city + "(" + station + ")"
            directionFrom = SelectedDirection(city: city,
                                              trainStations: station,
                                              direction: .from)
        }
    }
    
    func activeIfAllAdds() {
        guard let from = finalDirectionFrom, let to = finalDirectionTo else { return }
        
        allDirectionAdds = true
    }
    
    func filterCity(by word: String) {
        guard let cityList else { return }
        if word.isEmpty {
            needCityArray()
            return
        }
        
        let newList = cityList.filter { $0.localizedCaseInsensitiveContains(word) }
        
        if newList.isEmpty {
            listIsEmpty = true
        } else {
            self.cityList = newList
        }
    }
    
    func filterStation(by word: String) {
        guard let stationList else { return }
        
        if word.isEmpty {
            needStationForCity()
            return
        }
        
        let newList = stationList.filter { $0.localizedCaseInsensitiveContains(word) }
        
        if newList.isEmpty {
            listIsEmpty = true
        } else {
            self.stationList = newList
        }
    }
    
    func swapDirections() {
        // Меняем направления местами
        let tempFrom = directionFrom
        directionFrom = directionTo
        directionTo = tempFrom
        
        // Обновляем строковые представления
        finalDirectionFrom = directionFrom.map { $0.city + "(" + $0.trainStations + ")" }
        finalDirectionTo = directionTo.map { $0.city + "(" + $0.trainStations + ")" }
    }
}

