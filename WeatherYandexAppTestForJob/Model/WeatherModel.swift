//
//  WeatherModel.swift
//  WeatherYandexAppTestForJob
//
//  Created by Артем Орлов on 21.07.2022.
//

import Foundation

struct WeatherData: Codable {
    let info: Info
    let fact: Fact
    let forecast: [Forecast]
}

struct Info: Codable {
    let url: String
}

struct Fact: Codable {
    let temp: Int
    let icon: String
    let condition: String
    let windSpeed: Int
    let pressureMm: Int
    
    enum CodingKeys: String, CodingKey {
        case temp
        case icon
        case condition
        case windSpeed = "wind_speed"
        case pressureMm = "pressure_mm"
    }
}

struct Forecast: Codable {
    let parts: Parts
    
}

struct Parts: Codable {
    let day: Day
}

struct Day: Codable {
    let tempMin: Int?
    let tempMax: Int?
    
    enum CodingKeys: String, CodingKey {
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

enum Link: String {
    case apiKey = "18813eb7-163d-45a2-a181-6ca1149b0f99"
}
