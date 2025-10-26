import OpenAPIRuntime
import OpenAPIURLSession

typealias NearestStations = Components.Schemas.Stations
typealias CopyrightResponse = Components.Schemas.CopyrightResponse
typealias NearestSettlement = Components.Schemas.NearestSettlement
typealias Carrier = Components.Schemas.CarrierResponse

protocol NearestStationsServiceProtocol {
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations
}

protocol CopyrightProtocol {
    func getCopyright() async throws -> CopyrightResponse
}

protocol NearestSettlementProtocol {
    func getNearestSettlement(lat: Double, lng: Double) async throws -> NearestSettlement
}

protocol CarrierProtocol {
    func getCarrier(code: Double) async throws -> Carrier
}

final class CarrierService: CarrierProtocol {
    
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getCarrier(code: Double) async throws -> Carrier {
        let response = try await client.carrier(query: .init(apikey: apikey, code: code))
        return try response.ok.body.json
    }
}

final class NearestSettlementService: NearestSettlementProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getNearestSettlement(lat: Double, lng: Double) async throws -> NearestSettlement {
        let response = try await client.nearestSettlement(query: .init(apikey: apikey, lat: lat, lng: lng))
        return try response.ok.body.json
    }
}

final class NearestStationsService: NearestStationsServiceProtocol {
    // Хранит экземпляр сгенерированного клиента
    private let client: Client
    // Хранит API-ключ (лучше передавать его извне, чем хранить прямо в сервисе)
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
            apikey: apikey,     // Передаём API-ключ
            lat: lat,           // Передаём широту
            lng: lng,           // Передаём долготу
            distance: distance  // Передаём дистанцию
        ))
    
        // response.ok: Доступ к успешному ответу
        // .body: Получаем тело ответа
        // .json: Получаем объект из JSON в ожидаемом типе NearestStations
        return try response.ok.body.json
    }

}

final class getCopyrightServise: CopyrightProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getCopyright() async throws -> CopyrightResponse {
        let response = try await client.copyright(query: .init(
            apikey: apikey
        ))
        return try response.ok.body.json
    }
    
}
