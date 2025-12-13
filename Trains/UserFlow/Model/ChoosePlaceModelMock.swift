//  ChoosePlaceModelMock.swift

import Foundation

extension ChoosePlaceModel {
    static let mockCities: [ChoosePlaceModel] = [
        ChoosePlaceModel(
            cityName: "Москва",
            lat: "55.7558",
            lng: "37.6173",
            distance: "20"
        ),
        ChoosePlaceModel(
            cityName: "Санкт-Петербург",
            lat: "59.9343",
            lng: "30.3351",
            distance: "18"
        ),
        ChoosePlaceModel(
            cityName: "Нижний Новгород",
            lat: "56.3287",
            lng: "44.0021",
            distance: "13"
        )
    ]
}
