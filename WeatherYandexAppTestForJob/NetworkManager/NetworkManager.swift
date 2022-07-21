//
//  NetworkManager.swift
//  WeatherYandexAppTestForJob
//
//  Created by Артем Орлов on 21.07.2022.
//

import Foundation

struct NetworkManager {
    
    static let shared = NetworkManager()
    
    func fetchWeather(latitude: Double,longitude: Double ,completion: @escaping (Weather) -> Void) {
        
        let urlString = "https://api.weather.yandex.ru/v2/forecast?lat=\(latitude)&lon=\(longitude)"
                                                                    
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        request.addValue(Link.apiKey.rawValue, forHTTPHeaderField: "X-Yandex-API-Key")
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            print(String(data: data, encoding: .utf8)!)
            if let weather = self.parseJSOn(withData: data) {
                completion(weather)
            }
        }.resume()
    }
    
    func parseJSOn(withData data: Data) -> Weather? {
        let decoder = JSONDecoder()
        do {
            let weatherData = try decoder.decode(WeatherData.self, from: data)
            guard let weather = Weather(weatherData: weatherData) else {
                return nil
            }
            return weather
        } catch {
            print(error)
        }
        return nil
    }
}
