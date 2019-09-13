//
//  WeatherDetailsModel.swift
//  WeatherApp
//
//  Created by Kallas on 9/12/19.
//  Copyright © 2019 AK. All rights reserved.
//

import Foundation

struct WeatherDetailsModel {
    
    let temperature_2m: Double
    let temperature_sol: Double
    let temperature_500hpa: Double
    let temperature_850hpa: Double
    let pression: Int32
    let pluie: Double
    let pluieConvective: Double
    let humidity: Int16
    let ventMoyen: Int16
    let ventRafales: Int16
    let ventDirection: Int16
    let isoZero: Int32
    let risqueNeige: String?
    let cape: Int16
    let nebulositeHaute: Int16
    let nebulositeMoyenne: Int16
    let nebulositeBasse: Int16
    let nebulositeTotale: Int16
    let dateTime: String?
    
    static func from(weatherData: WeatherData) -> WeatherDetailsModel {
        return WeatherDetailsModel(temperature_2m: weatherData.temperature_2m, temperature_sol: weatherData.temperature_sol, temperature_500hpa: weatherData.temperature_500hpa, temperature_850hpa: weatherData.temperature_850hpa, pression: weatherData.pression, pluie: weatherData.pluie, pluieConvective: weatherData.pluieConvective, humidity: weatherData.humidity, ventMoyen: weatherData.ventMoyen, ventRafales: weatherData.ventRafales, ventDirection: weatherData.ventDirection, isoZero: weatherData.isoZero, risqueNeige: weatherData.risqueNeige, cape: weatherData.cape, nebulositeHaute: weatherData.nebulositeHaute, nebulositeMoyenne: weatherData.nebulositeMoyenne, nebulositeBasse: weatherData.nebulositeBasse, nebulositeTotale: weatherData.nebulositeTotale, dateTime: weatherData.dateTime)
    }
}
