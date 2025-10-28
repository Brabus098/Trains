//  AllStationsService.swift

import OpenAPIRuntime
import OpenAPIURLSession
import Foundation

typealias AllStationsResponse = Components.Schemas.AllStationsResponse

protocol AllStationsResponseProtocol {
    func getAllStations() async throws -> AllStationsResponse
}

final class AllStationsResponseService: AllStationsResponseProtocol {
    
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getAllStations() async throws -> AllStationsResponse {
        let response = try await client.getAllStations(query: .init(apikey: apikey))
        
        let responseBody = try response.ok.body.text_html_charset_utf_hyphen_8
        
        let limit = 50 * 1024 * 1024
        var fullData = try await Data(collecting: responseBody, upTo: limit)
        
        let allStations = try JSONDecoder().decode(AllStationsResponse.self, from: fullData)
        print(String(data: fullData.prefix(15000), encoding: .utf8) ?? "")
        
        return allStations
    }
}
