//
//  WeatherListViewModelProtocol.swift
//  WeatherApp
//
//  Created by Kallas on 9/13/19.
//  Copyright © 2019 AK. All rights reserved.
//

import Foundation

protocol WeatherListViewModelProtocol : BaseViewModelProtocol {
    func requestLocation()
    
    func getDidInsertObjectAtIndextPathObservable() -> Observable<WeatherCellViewNotificationObject>
    
    func getDidDeleteObjectAtIndextPathObservable() -> Observable<WeatherCellViewNotificationObject>
    
    func getDidMoveObjectAtIndextPathObservable() -> Observable<WeatherCellViewNotificationObject>
    
    func getDidUpdateObjectAtIndextPathObservable() -> Observable<WeatherCellViewNotificationObject>
    
    func getWillChangeContentObservable() -> Observable<Void>
    
    func getDidChangeContentObservable() -> Observable<Void>
    
    func getWeatherDataCount() -> Int
    
    func getSingleWeather(at indexPath:IndexPath) -> WeatherCellModel?
    
    func singleWeatherDataViewModel(from weatherCellModel:WeatherCellModel) -> SingleWeatherDataViewModel
    
    func didSelectCellAtIndexPath(indexPath:IndexPath)
    
    func getDidSelectCellAtIndexPathObservable() -> Observable<WeatherDetailsModel>
    
    func getAlertControlleErrorObserver() -> Observable<AlertControllerStruct>
}
