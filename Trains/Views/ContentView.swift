//
//  ContentView.swift
//  Trains
//
//  Created by Владимир on 17.10.2025.
//

import SwiftUI
import OpenAPIURLSession

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            //testFetchStations()
            //testFetchCopyright()
            //testFetchNearestStations()
            testFetchCarrier()
        }
    }
    
    func testFetchCarrier() {
        Task {
            do {
                // 1. Создаём экземпляр сгенерированного клиента
                let client = Client(
                    // Используем URL сервера, также сгенерированный из openapi.yaml (если он там определён)
                    serverURL: try Servers.Server1.url(),
                    // Указываем, какой транспорт использовать для отправки запросов
                    transport: URLSessionTransport()
                )
                
                // 2. Создаём экземпляр нашего сервиса, передавая ему клиент и API-ключ
                let service = CarrierService(client: client, apikey: "11758c37-0b0f-43a1-9378-a522f04edfae")
                // 3. Вызываем метод сервиса
                print("Fetching stations...")
                let stations = try await service.getCarrier(code: 680)
                
                // 4. Если всё успешно, печатаем результат в консоль
                print("Successfully fetched stations: \(stations)")
            } catch {
                // 5. Если произошла ошибка на любом из этапов (создание клиента, вызов сервиса, обработка ответа),
                //    она будет поймана здесь, и мы выведем её в консоль
                print("Error fetching stations: \(error)")
                // В реальном приложении здесь должна быть логика обработки ошибок (показ алерта и т. д.)
            }
        }
    }
    
    // Функция для тестового вызова API
    func testFetchStations() {
        Task {
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )
                
                // 2. Создаём экземпляр нашего сервиса, передавая ему клиент и API-ключ
                let service = NearestStationsService(
                    client: client,
                    apikey: "11758c37-0b0f-43a1-9378-a522f04edfae"
                )
                
                // 3. Вызываем метод сервиса
                print("Fetching stations...")
                let stations = try await service.getNearestStations(
                    lat: 59.864177, // Пример координат
                    lng: 30.319163, // Пример координат
                    distance: 50    // Пример дистанции
                )
                
                // 4. Если всё успешно, печатаем результат в консоль
                print("Successfully fetched stations: \(stations)")
            } catch {
                // 5. Если произошла ошибка на любом из этапов (создание клиента, вызов сервиса, обработка ответа),
                //    она будет поймана здесь, и мы выведем её в консоль
                print("Error fetching stations: \(error)")
                // В реальном приложении здесь должна быть логика обработки ошибок (показ алерта и т. д.)
            }
        }
    }
    
    func testFetchCopyright() {
        Task {
            do {
                let client = Client(
                    // Используем URL сервера, также сгенерированный из openapi.yaml (если он там определён)
                    serverURL: try Servers.Server1.url(),
                    // Указываем, какой транспорт использовать для отправки запросов
                    transport: URLSessionTransport()
                )
                
                // 2. Создаём экземпляр нашего сервиса, передавая ему клиент и API-ключ
                let service = getCopyrightServise(client: client, apikey: "11758c37-0b0f-43a1-9378-a522f04edfae")
                
                // 3. Вызываем метод сервиса
                print("Fetching stations...")
                let baners = try await service.getCopyright()
                
                // 4. Если всё успешно, печатаем результат в консоль
                print("Successfully fetched stations: \(baners)")
            } catch {
                // 5. Если произошла ошибка на любом из этапов (создание клиента, вызов сервиса, обработка ответа),
                //    она будет поймана здесь, и мы выведем её в консоль
                print("Error fetching stations: \(error)")
                // В реальном приложении здесь должна быть логика обработки ошибок (показ алерта и т. д.)
            }
        }
    }

    func testFetchNearestStations() {
        Task {
            do {
                let client = Client(
                    // Используем URL сервера, также сгенерированный из openapi.yaml (если он там определён)
                    serverURL: try Servers.Server1.url(),
                    // Указываем, какой транспорт использовать для отправки запросов
                    transport: URLSessionTransport()
                )
                
                // 2. Создаём экземпляр нашего сервиса, передавая ему клиент и API-ключ
                let service = NearestSettlementService(client: client, apikey: "11758c37-0b0f-43a1-9378-a522f04edfae")
                
                // 3. Вызываем метод сервиса
                print("Fetching stations...")
                let baners = try await service.getNearestSettlement(lat: 59.864177, lng: 30.319163)
                
                // 4. Если всё успешно, печатаем результат в консоль
                print("Successfully fetched stations: \(baners)")
            } catch {
                // 5. Если произошла ошибка на любом из этапов (создание клиента, вызов сервиса, обработка ответа),
                //    она будет поймана здесь, и мы выведем её в консоль
                print("Error fetching stations: \(error)")
                // В реальном приложении здесь должна быть логика обработки ошибок (показ алерта и т. д.)
            }
        }
    }
    
}

#Preview {
    ContentView()
}
