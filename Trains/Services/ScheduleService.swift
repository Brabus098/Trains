// ScheduleService.swift

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias SchedualStation = Components.Schemas.ScheduleResponse

protocol ScheduleServiceProtocol {
    func getStationSchedule(station: String) async throws -> SchedualStation
}

final class ScheduleService: ScheduleServiceProtocol {
    var apikey: String
    var client: Client
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    func getStationSchedule(station: String) async throws -> SchedualStation {
        let response = try await client.getStationSchedule(query: .init(apikey: apikey, station: station))
        return try response.ok.body.json
    }
}
