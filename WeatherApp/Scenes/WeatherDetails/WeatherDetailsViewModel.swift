//
//  WeatherDetailsViewModel.swift
//  WeatherApp
//
//  Created by Kallas on 9/12/19.
//  Copyright © 2019 AK. All rights reserved.
//

import Foundation

class WeatherDetailsViewModel : WeatherDetailsViewModelProtocol {
    var weatherDetailsModel: WeatherDetailsModel
    
    init(weatherDetailsModel: WeatherDetailsModel) {
        self.weatherDetailsModel = weatherDetailsModel
    }
    
    
    private let _weatherDetailsObservers: Observable<WeatherDetailsModel> = Observable()
    
    func getWeatherDetailsObserver() -> Observable<WeatherDetailsModel> {
        return _weatherDetailsObservers
    }
    
    func getWeatherDetails(){
        _weatherDetailsObservers.value = self.weatherDetailsModel
    }
    
    func clearObservers() {
        _weatherDetailsObservers.unbindAll()
    }
    
}
