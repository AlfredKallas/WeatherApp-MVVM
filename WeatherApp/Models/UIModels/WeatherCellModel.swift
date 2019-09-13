//
//  WeatherCellModel.swift
//  WeatherApp
//
//  Created by Kallas on 9/12/19.
//  Copyright © 2019 AK. All rights reserved.
//

import Foundation

struct WeatherCellModel {
    let dateTime:String?
    let temperature:Int
    
    static func from(weatherData: WeatherData) -> WeatherCellModel {
        return WeatherCellModel(dateTime: weatherData.dateTime, temperature: Int(weatherData.temperature_2m))
    }
}
