//
//  Weather.swift
//  WeatherYandexAppTestForJob
//
//  Created by Артем Орлов on 21.07.2022.
//

import Foundation

struct Weather {
    
    var name = "Название"
    var temperature = 0.0
    var temperatureString: String {
        return String(format: "%.0f", temperature)
    }
    var conditionCode = ""
    var url = ""
    var condition = ""
    var presureMm = 0
    var windSpeed = 0.0
    var tempMin = 0
    var tempMax = 0
    
    var conditionString: String {
        
        switch condition {
        case "clear":                           return "Ясно"
        case "partly-cloudy":                   return "Малооблачно"
        case "cloudy":                          return "Облачно с прояснениями"
        case "overcast":                        return "Пасмурно"
        case "drizzle":                         return "Морось"
        case "light-rain":                      return "Небольшой дождь"
        case "rain":                            return "Дождь"
        case "moderate-rain":                   return "Умеренно сильный дождь"
        case "heavy-rain":                      return "Cильный дождь"
        case "continuous-heavy-rain":           return "Длительный сильный дождь"
        case "showers":                         return "Ливень"
        case "wet-snow":                        return "Дождь со снегом"
        case "light-snow":                      return "Небольшой снег"
        case "snow":                            return "Снег"
        case "snow-showers":                    return "Снегопад"
        case "hail":                            return "Град"
        case "thunderstorm":                    return "Гроза"
        case "thunderstorm-with-rain":          return "Дождь с грозой"
        case "thunderstorm-with-hail":          return "Гроза с градом"
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
        tempMin = weatherData.forecasts.first?.parts.day.tempMin ?? 0
        tempMax = weatherData.forecasts.first?.parts.day.tempMax ?? 0
    }
    
    init () {}
}
