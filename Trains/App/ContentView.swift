//  ContentView.swift

import SwiftUI
import OpenAPIURLSession

struct ContentView: View {
    
    var apikey = "11758c37-0b0f-43a1-9378-a522f04edfae"
    var body: some View {
        CustomTabView()
    }
    //        .onAppear {
    //
    //            testScheduleResponse()
    //            testFetchStations()
    //            testFetchCopyright()
    //            testFetchNearestStations()
    //            testFetchCarrier()
    //            testFetchSchedualBetweenStations()
    //            testRouteStations()
    //            testAllStation()
    
    
    //    //Список рейсов по станции ok
    //    func testScheduleResponse() {
    //        Task {
    //            do {
    //                let client = Client(
    //                    serverURL: try Servers.Server1.url(),
    //                    transport: URLSessionTransport()
    //                )
    //
    //                let service = ScheduleService(client: client, apikey: apikey)
    //
    //                print("Fetching stations...")
    //
    //                let stations = try await service.getStationSchedule(station: "s9600213")
    //
    //                print("Successfully fetched stations: \(stations)")
    //            } catch {
    //                print("Error fetching stations: \(error)")
    //            }
    //        }
    //    }
    //    // Список всех станций ok
    //    func testAllStation() {
    //        Task {
    //            do {
    //                let client = Client(
    //                    serverURL: try Servers.Server1.url(),
    //                    transport: URLSessionTransport()
    //                )
    //                let service = AllStationsResponseService(client: client, apikey: apikey)
    //
    //                print("Fetching stations...")
    //                let stations = try await service.getAllStations()
    //
    //                print("Successfully fetched stations: \(stations)")
    //            } catch {
    //                print("Error fetching stations: \(error)")
    //            }
    //        }
    //    }
    //    // Список станций следования ok
    //    func testRouteStations() {
    //        Task {
    //            do {
    //                let client = Client(
    //                    serverURL: try Servers.Server1.url(),
    //                    transport: URLSessionTransport()
    //                )
    //                let service = RouteStationsService(client: client, apikey: apikey)
    //
    //
    //                print("Fetching stations...")
    //                let stations = try await service.getRouteStations(name: "078S_9_2")
    //
    //                print("Successfully fetched stations: \(stations)")
    //            } catch {
    //                print("Error fetching stations: \(error)")
    //            }
    //        }
    //    }
    //    // Расписание рейсов между станциями ok
    //    func testFetchSchedualBetweenStations() {
    //        Task {
    //            do {
    //                let client = Client(
    //                    serverURL: try Servers.Server1.url(),
    //                    transport: URLSessionTransport()
    //                )
    //                let service = SchedualBetweenStationsService(client: client, apikey: apikey)
    //                print("Fetching stations...")
    //                let stations = try await service.getSchedualBetweenStations(from: "s2000001", to: "s9602494")
    //
    //                print("Successfully fetched stations: \(stations)")
    //            } catch {
    //                print("Error fetching stations: \(error)")
    //            }
    //        }
    //    }
    //    // Информация о перевозчике ok
    //    func testFetchCarrier() {
    //        Task {
    //            do {
    //                let client = Client(
    //                    serverURL: try Servers.Server1.url(),
    //                    transport: URLSessionTransport()
    //                )
    //                let service = CarrierService(client: client, apikey: apikey)
    //                print("Fetching stations...")
    //                let stations = try await service.getCarrier(code: "680", system: nil)
    //
    //                print("Successfully fetched stations: \(stations)")
    //            } catch {
    //                print("Error fetching stations: \(error)")
    //            }
    //        }
    //    }
    //    // Список ближайших станций ok
    //    func testFetchStations() {
    //        Task {
    //            do {
    //                let client = Client(
    //                    serverURL: try Servers.Server1.url(),
    //                    transport: URLSessionTransport()
    //                )
    //                let service = NearestStationsService(
    //                    client: client,
    //                    apikey: apikey
    //                )
    //                print("Fetching stations...")
    //                let stations = try await service.getNearestStations(
    //                    lat: 59.864177,
    //                    lng: 30.319163,
    //                    distance: 50
    //                )
    //                print("Successfully fetched stations: \(stations)")
    //            } catch {
    //                print("Error fetching stations: \(error)")
    //            }
    //        }
    //    }
    //    // Копирайт ok
    //    func testFetchCopyright() {
    //        Task {
    //            do {
    //                let client = Client(
    //                    serverURL: try Servers.Server1.url(),
    //                    transport: URLSessionTransport()
    //                )
    //                let service = GetCopyrightService(client: client, apikey: apikey)
    //                print("Fetching stations...")
    //                let baners = try await service.getCopyright()
    //                print("Successfully fetched stations: \(baners)")
    //            } catch {
    //                print("Error fetching stations: \(error)")
    //            }
    //        }
    //    }
    //    // Ближайший город ok
    //    func testFetchNearestStations() {
    //        Task {
    //            do {
    //                let client = Client(
    //                    // Используем URL сервера, также сгенерированный из openapi.yaml (если он там определён)
    //                    serverURL: try Servers.Server1.url(),
    //                    // Указываем, какой транспорт использовать для отправки запросов
    //                    transport: URLSessionTransport()
    //                )
    //
    //                // 2. Создаём экземпляр нашего сервиса, передавая ему клиент и API-ключ
    //                let service = NearestSettlementService(client: client, apikey: apikey)
    //
    //                // 3. Вызываем метод сервиса
    //                print("Fetching stations...")
    //                let baners = try await service.getNearestSettlement(lat: 59.864177, lng: 30.319163)
    //
    //                // 4. Если всё успешно, печатаем результат в консоль
    //                print("Successfully fetched stations: \(baners)")
    //            } catch {
    //                // 5. Если произошла ошибка на любом из этапов (создание клиента, вызов сервиса, обработка ответа),
    //                //    она будет поймана здесь, и мы выведем её в консоль
    //                print("Error fetching stations: \(error)")
    //                // В реальном приложении здесь должна быть логика обработки ошибок (показ алерта и т. д.)
    //            }
    //        }
    //    }
    
}

