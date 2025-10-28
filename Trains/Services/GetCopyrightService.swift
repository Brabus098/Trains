//  GetCopyrightService.swift

import OpenAPIRuntime
import OpenAPIURLSession

typealias CopyrightResponse = Components.Schemas.CopyrightResponse

protocol CopyrightProtocol {
    func getCopyright() async throws -> CopyrightResponse
}

final class GetCopyrightService: CopyrightProtocol {
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
