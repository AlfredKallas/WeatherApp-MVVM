//
//  WeatherDetailsViewModelProtocol.swift
//  WeatherApp
//
//  Created by Kallas on 9/13/19.
//  Copyright © 2019 AK. All rights reserved.
//

import Foundation

protocol WeatherDetailsViewModelProtocol : BaseViewModelProtocol {
    var weatherDetailsModel: WeatherDetailsModel { get set }
    
    func getWeatherDetailsObserver() -> Observable<WeatherDetailsModel>
    
    func getWeatherDetails()
}
