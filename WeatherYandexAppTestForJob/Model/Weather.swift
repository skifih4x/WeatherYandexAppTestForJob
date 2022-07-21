//
//  Weather.swift
//  WeatherYandexAppTestForJob
//
//  Created by Артем Орлов on 21.07.2022.
//

import Foundation

struct Weather {
    
    var name = "Название"
    var temperature: Int
    var conditionCode: String
    var url: String
    var condition: String
    var presureMm: Int
    var windSpeed: Int
    var tempMin = 0
    var tempMax = 0
    
    var conditionString: String {
        
        switch condition {
        case "clear":                           return "Ясно"
        case "partly-cloudy":                   return "Малооблачно"
        case "cloudy":                          return "Облачно с прояснениями"
        case "overcast":                        return "Пасмурно"
        case "drizzle":                         return "морось"
        case "light-rain":                      return "небольшой дождь"
        case "rain":                            return "дождь"
        case "moderate-rain":                   return "умеренно сильный дождь"
        case "heavy-rain":                      return "сильный дождь"
        case "continuous-heavy-rain":           return "длительный сильный дождь"
        case "showers":                         return "ливень"
        case "wet-snow":                        return "дождь со снегом"
        case "light-snow":                      return "небольшой снег"
        case "snow":                            return "снег"
        case "snow-showers":                    return "снегопад"
        case "hail":                            return "град"
        case "thunderstorm":                    return "гроза"
        case "thunderstorm-with-rain":          return "дождь с грозой"
        case "thunderstorm-with-hail":          return "гроза с градом"
        default:
            return "Загрузка..."
        }
    }
    
    init?(weatherData: WeatherData) {
        
        temperature = weatherData.fact.temp
        conditionCode = weatherData.fact.icon
        url = weatherData.info.url
        condition = weatherData.fact.condition
        presureMm = weatherData.fact.pressureMm
        windSpeed = weatherData.fact.windSpeed
        tempMin = weatherData.forecast.first?.parts.day.tempMin ?? 0
        tempMax = weatherData.forecast.first?.parts.day.tempMax ?? 0
    }
}
