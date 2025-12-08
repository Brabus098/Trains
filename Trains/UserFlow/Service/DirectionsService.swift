//  MainScreenViewModel.swift

import Observation
import Combine

@Observable final class DirectionsService {
    
    private let allDirectionAddsSubject = CurrentValueSubject<Bool?,Never>(nil)
    private let finalDirectionToSubject = CurrentValueSubject<String?,Never>(nil)
    private var finalDirectionFrom: String? {
        finalDirectionFromSubject.value
    }
    private var finalDirectionTo: String? {
        finalDirectionToSubject.value
    }
    private let directionToSubject = CurrentValueSubject<DirectionModel?,Never>(nil)
    private var directionTo: DirectionModel? {
        directionToSubject.value
    }
    private let directionFromSubject = CurrentValueSubject<DirectionModel?,Never>(nil)
    private let finalDirectionFromSubject = CurrentValueSubject<String?,Never>(nil)
    
    
    var allDirectionAddsPublisher: AnyPublisher<Bool?,Never> {
        allDirectionAddsSubject.eraseToAnyPublisher()
    }
    var finalDirectionToPublisher: AnyPublisher<String?,Never> {
        finalDirectionToSubject.eraseToAnyPublisher()
    }
    var finalDirectionFromPublisher: AnyPublisher<String?,Never> {
        finalDirectionFromSubject.eraseToAnyPublisher()
    }
    var directionToPublisher: AnyPublisher<DirectionModel?,Never> {
        directionToSubject.eraseToAnyPublisher()
    }
    var directionFromPublisher: AnyPublisher<DirectionModel?,Never> {
        directionFromSubject.eraseToAnyPublisher()
    }
    var directionFrom: DirectionModel? {
        directionFromSubject.value
    }
    
    var directionType: DirectionType?
    var selectedCity: String?
    var selectedStation: String?
    
    func swapDirections() {
        // Меняем направления местами
        let tempFrom = directionFrom
        directionFromSubject.send(directionTo)
        directionToSubject.send(tempFrom)
        
        // Обновляем строковые представления
        finalDirectionFromSubject.send(directionFrom.map { $0.city + "(" + $0.trainStations + ")" })
        finalDirectionToSubject.send( directionTo.map { $0.city + "(" + $0.trainStations + ")" })
    }
    
    func activeIfAllAdds() {
        guard let from = finalDirectionFrom, let to = finalDirectionTo else { return }
        allDirectionAddsSubject.send(true)
    }
    
    func containsDestinationIfCan() {
        guard let city = selectedCity, let station = selectedStation, let direction = directionType else { return }
        
        if direction == .to {
            finalDirectionToSubject.send(city + "(" + station + ")")
            directionToSubject.send(DirectionModel(city: city,
                                                   trainStations: station,
                                                   direction: .to))
        } else if direction == .from {
            finalDirectionFromSubject.send(city + "(" + station + ")")
            directionFromSubject.send(DirectionModel(city: city,
                                                     trainStations: station,
                                                     direction: .from))
        }
    }
}
