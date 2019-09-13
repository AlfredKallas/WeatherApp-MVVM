//
//  WeatherDataCell.swift
//  WeatherApp
//
//  Created by Kallas on 9/11/19.
//  Copyright © 2019 AK. All rights reserved.
//

import Foundation
import UIKit

class WeatherDataCell: UITableViewCell {
    @IBOutlet weak var dateTimeLabel:UILabel!
    
    @IBOutlet weak var temperatureLabel:UILabel!
    
    func configureCell(singleWeatherDataViewModel: SingleWeatherDataViewModel?){
        dateTimeLabel.text = singleWeatherDataViewModel?.dateTime
        temperatureLabel.text = singleWeatherDataViewModel?.temperature
    }
    
    static func cellIdentifier() -> String {
        return "WeatherDataCell"
    }
}
