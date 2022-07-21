//
//  GetCitiesWeather.swift
//  WeatherYandexAppTestForJob
//
//  Created by Артем Орлов on 21.07.2022.
//

import Foundation
import CoreLocation


func getCityWeather(citiesArray: [String], completion: @escaping (Int, Weather) -> Void ) {
    
    for (index, item) in citiesArray.enumerated() {
        getCoordinateFrom(city: item) { coordinate, error in
            guard let coordinate = coordinate, error == nil else { return }
            
            NetworkManager.shared.fetchWeather(latitude: coordinate.latitude, longitude: coordinate.longitude) { weather in
                completion(index, weather)
            }
        }
    }
}

func getCoordinateFrom(city: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ) {
    CLGeocoder().geocodeAddressString(city) { placemark, error in
        completion(placemark?.first?.location?.coordinate, error)
    }
}

