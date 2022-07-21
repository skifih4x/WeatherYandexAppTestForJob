//
//  DetailsViewController.swift
//  WeatherYandexAppTestForJob
//
//  Created by Артем Орлов on 21.07.2022.
//

import UIKit
import SwiftSVG

class DetailsViewController: UIViewController {
    
    @IBOutlet var nameCityLabel: UILabel!
    @IBOutlet var viewCity: UIView!
    @IBOutlet var conditionLabel: UILabel!
    @IBOutlet var tempCityLabel: UILabel!
    
    @IBOutlet var pressureLabel: UILabel!
    @IBOutlet var windSpeedLabel: UILabel!
    @IBOutlet var minTempLabel: UILabel!
    @IBOutlet var maxTempLabel: UILabel!
    
    var weatherModel: Weather?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshLabel()
        
    }
    func refreshLabel() {
        nameCityLabel.text = weatherModel?.name
        
        let url = URL(string: "https://yastatic.net/weather/i/icons/blueye/color/svg/\(weatherModel?.conditionCode ?? "").svg")
        
        let weatherImage = UIView(SVGURL: url!) { image in
            image.resizeToFit(self.viewCity.bounds)
        }
        self.viewCity.addSubview(weatherImage)
        
        conditionLabel.text = weatherModel?.conditionString
        tempCityLabel.text = weatherModel?.temperatureString
        pressureLabel.text = "\((weatherModel?.presureMm) ?? 0)"
        windSpeedLabel.text = "\((weatherModel?.windSpeed) ?? 0)"
        minTempLabel.text = "\((weatherModel?.tempMin) ?? 0)"
        maxTempLabel.text = "\((weatherModel?.tempMax) ?? 0)"
    }

    

}
