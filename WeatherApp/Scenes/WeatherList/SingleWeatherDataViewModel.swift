//
//  SingleWeatherDataViewModel.swift
//  WeatherApp
//
//  Created by Kallas on 9/11/19.
//  Copyright © 2019 AK. All rights reserved.
//

import Foundation

class SingleWeatherDataViewModel: NSObject {
    var dateTime:String!
    var temperature:String!
    
    static func from (weatherCellModel: WeatherCellModel) -> SingleWeatherDataViewModel {
        let singleWeatherDataViewModel = SingleWeatherDataViewModel()
        singleWeatherDataViewModel.dateTime = weatherCellModel.dateTime
        singleWeatherDataViewModel.temperature = "\(weatherCellModel.temperature)"
        return singleWeatherDataViewModel
    }
}
