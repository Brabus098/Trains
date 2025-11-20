//  ChoosePlaceModelMock.swift

import Foundation

extension ChoosePlaceModel {
    static let mockCities: [ChoosePlaceModel] = [
        ChoosePlaceModel(
            city: "Москва",
            trainStations: [
                "Курский вокзал",
                "Казанский вокзал",
                "Ярославский вокзал",
                "Ленинградский вокзал",
                "Киевский вокзал",
                "Павелецкий вокзал",
                "Рижский вокзал",
                "Белорусский вокзал",
                "Савеловский вокзал"
            ]
        ),
        
        ChoosePlaceModel(
            city: "Санкт-Петербург",
            trainStations: [
                "Московский вокзал",
                "Ладожский вокзал",
                "Финляндский вокзал",
                "Балтийский вокзал",
                "Витебский вокзал"
            ]
        ),
        
        ChoosePlaceModel(
            city: "Новосибирск",
            trainStations: [
                "Новосибирск-Главный",
                "Новосибирск-Южный",
                "Новосибирск-Западный"
            ]
        ),
        
        ChoosePlaceModel(
            city: "Екатеринбург",
            trainStations: [
                "Екатеринбург-Пассажирский",
                "Екатеринбург-Сортировочный",
                "Станция Шарташ"
            ]
        ),
        
        ChoosePlaceModel(
            city: "Казань",
            trainStations: [
                "Казань-Пассажирская",
                "Восстание-Пассажирская",
                "Станция Казань-2"
            ]
        ),
        
        ChoosePlaceModel(
            city: "Нижний Новгород",
            trainStations: [
                "Нижний Новгород-Московский",
                "Нижний Новгород-Сортировочный",
                "Станция Мыза"
            ]
        ),
        
        ChoosePlaceModel(
            city: "Челябинск",
            trainStations: [
                "Челябинск-Главный",
                "Челябинск-Южный",
                "Станция Шершни"
            ]
        ),
        
        ChoosePlaceModel(
            city: "Самара",
            trainStations: [
                "Самара-Пассажирская",
                "Самара-Безымянка",
                "Станция Кряж"
            ]
        ),
        
        ChoosePlaceModel(
            city: "Омск",
            trainStations: [
                "Омск-Пассажирский",
                "Омск-Пригородный",
                "Станция Московка"
            ]
        ),
        
        ChoosePlaceModel(
            city: "Ростов-на-Дону",
            trainStations: [
                "Ростов-Главный",
                "Ростов-Товарный",
                "Станция Первомайская"
            ]
        )
    ]
}
