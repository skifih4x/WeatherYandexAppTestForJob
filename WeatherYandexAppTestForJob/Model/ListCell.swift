//
//  ListCell.swift
//  WeatherYandexAppTestForJob
//
//  Created by Артем Орлов on 21.07.2022.
//

import UIKit

class ListCell: UITableViewCell {
    
    @IBOutlet var nameCityLabel: UILabel!
    @IBOutlet var conditionCityLabel: UILabel!
    @IBOutlet var tempCityLabel: UILabel!
     
    func configure(weather: Weather) {
        nameCityLabel.text = weather.name
        conditionCityLabel.text = weather.conditionString
        tempCityLabel.text = weather.temperatureString
    }
    
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
