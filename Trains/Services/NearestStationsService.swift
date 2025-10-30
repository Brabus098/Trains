// NearestStationsService.swift

import OpenAPIRuntime
import OpenAPIURLSession

typealias NearestStations = Components.Schemas.Stations

protocol NearestStationsServiceProtocol {
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations
}

final class NearestStationsService: NearestStationsServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations {
        // Вызываем функцию getNearestStations на ЭКЗЕМПЛЯРЕ сгенерированного клиента.
        // Имя функции и параметры 'query' напрямую соответствуют операции
        // 'getNearestStations' и её параметрам в openapi.yaml
        let response = try await client.getNearestStations(query: .init(
            apikey: apikey,
            lat: lat,
            lng: lng,
            distance: distance
        ))
        
        // response.ok: Доступ к успешному ответу
        // .body: Получаем тело ответа
        // .json: Получаем объект из JSON в ожидаемом типе NearestStations
        return try response.ok.body.json
    }
}
