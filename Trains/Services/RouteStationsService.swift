//  RouteStationsService.swift

import OpenAPIRuntime
import OpenAPIURLSession

typealias RouteStationsResponse = Components.Schemas.ThreadStationsResponse

protocol RouteStationsProtocol {
    func getRouteStations(name: String) async throws -> RouteStationsResponse
}

final class RouteStationsService: RouteStationsProtocol {
    
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getRouteStations(name: String) async throws -> RouteStationsResponse {
        let response = try await client.getRouteStations(query: .init(apikey: apikey, uid: name))
        return try response.ok.body.json
    }
}
