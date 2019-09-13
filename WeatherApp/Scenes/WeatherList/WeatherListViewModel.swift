//
//  WeatherListViewModel.swift
//  WeatherApp
//
//  Created by Kallas on 9/8/19.
//  Copyright © 2019 AK. All rights reserved.
//

import Foundation
import CoreData

class WeatherListViewModel {
    
    private var locationService: LocationService?
    
    private let _didInsertObjectAtIndexPath: Observable<WeatherCellViewNotificationObject> = Observable()
    private let _didDeleteObjectAtIndexPath: Observable<WeatherCellViewNotificationObject> = Observable()
    private let _didMoveObjectAtIndexPath: Observable<WeatherCellViewNotificationObject> = Observable()
    private let _didUpdateObjectAtIndexPath: Observable<WeatherCellViewNotificationObject> = Observable()
    
    private let _willChangeContent: Observable<Void> = Observable()
    private let _didChangeContent: Observable<Void> = Observable()
    
    private let _didSelectCellAtIndexPath:Observable<WeatherDetailsModel> = Observable()
    
    private let _alertControlleError: Observable<AlertControllerStruct> = Observable()
    
    var weatherListFetchController:WeatherListFetchController? {
        didSet{
            perfromFetch()
        }
    }
    
    private lazy var fetchedResultsController: NSFetchedResultsController<WeatherData> = {
        
        let fetchRequest = NSFetchRequest<WeatherData>(entityName: "WeatherData")
        
        // Add Sort Descriptors
        let sortDescriptor = NSSortDescriptor(key: "dateTime", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Initialize Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController<WeatherData>(fetchRequest: fetchRequest, managedObjectContext: CoreDataController.shared.mainContext, sectionNameKeyPath: nil, cacheName: nil)
        
        // Configure Fetched Results Controller
        fetchedResultsController.delegate = weatherListFetchController
        
        return fetchedResultsController
    }()

    init(locationService:LocationService) {
        self.locationService = locationService
        self.locationService?.locationServiceUpdatedObservable.bind(observer: { [weak self] (observable, locations) in
            guard let newLocation = locations.last else { return }
            self?.getWeatherByLocation(longitude: newLocation.coordinate.longitude, latitude: newLocation.coordinate.latitude)
        })
        
        self.locationService?.locationServiceNotAllowedObservable.bind(observer: { [weak self](observer, void) in
            self?._alertControlleError.value = AlertControllerStruct(message: "Location Services Not enabled. Please go to settings to enable.",actionButtonTitle: "Ok")
        })
    }
    
    
    
    private func perfromFetch(){
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print(error)
        }
    }
    
    private func getWeatherByLocation(longitude:Double, latitude:Double) {
        WeatherRequest.weatherByRegion(longitude: longitude, latitude: latitude).send(WeattherAPIResponse.self) { [weak self](response) in
            switch response {
            case .failure(let error):
                // TODO: - Handle error as you want, printing isn't handling.
                self?._alertControlleError.value = AlertControllerStruct(message: error?.errorDescription ?? "Error Fetching Data from network please try again later.",actionButtonTitle: "Ok")
                print()
            case .success(let value):
                CoreDataController.shared.saveData(saveBlock: { (context) in
                        WeatherData.createOrUpdateFromWeatherApiData(weatherAPIData: value.weatherInDateTimeList, in: context)
                })
            }
        }
    }
    
}

extension WeatherListViewModel: WeatherListViewModelProtocol {
    
    public func requestLocation(){
        self.locationService?.setup()
    }
    
    public func getDidInsertObjectAtIndextPathObservable() -> Observable<WeatherCellViewNotificationObject> {
        return _didInsertObjectAtIndexPath
    }
    
    public func getDidDeleteObjectAtIndextPathObservable() -> Observable<WeatherCellViewNotificationObject> {
        return _didDeleteObjectAtIndexPath
    }
    
    public func getDidMoveObjectAtIndextPathObservable() -> Observable<WeatherCellViewNotificationObject> {
        return _didMoveObjectAtIndexPath
    }
    
    public func getDidUpdateObjectAtIndextPathObservable() -> Observable<WeatherCellViewNotificationObject>{
        return _didUpdateObjectAtIndexPath
    }
    
    public func getWillChangeContentObservable() -> Observable<Void> {
        return _willChangeContent
    }
    
    public func getDidChangeContentObservable() -> Observable<Void> {
        return _didChangeContent
    }
    
    public func getWeatherDataCount() -> Int {
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    public func getSingleWeather(at indexPath:IndexPath) -> WeatherCellModel? {
        guard let weatherData = fetchedResultsController.fetchedObjects?[indexPath.row] else {
            return nil
        }
        
        return WeatherCellModel.from(weatherData: weatherData)
    }
    
    public func singleWeatherDataViewModel(from weatherCellModel:WeatherCellModel) -> SingleWeatherDataViewModel {
        return SingleWeatherDataViewModel.from(weatherCellModel: weatherCellModel)
    }
    
    public func didSelectCellAtIndexPath(indexPath:IndexPath){
        guard let weatherData = self.fetchedResultsController.fetchedObjects?[indexPath.row] else { return }
        let weatherDetailsModel = WeatherDetailsModel.from(weatherData: weatherData)
        _didSelectCellAtIndexPath.value = weatherDetailsModel
    }
    
    public func getDidSelectCellAtIndexPathObservable() -> Observable<WeatherDetailsModel> {
        return _didSelectCellAtIndexPath
    }
    
    public func getAlertControlleErrorObserver() -> Observable<AlertControllerStruct> {
        return _alertControlleError
    }
    
    public func clearObservers(){
        _didInsertObjectAtIndexPath.unbindAll()
        _didDeleteObjectAtIndexPath.unbindAll()
        _didMoveObjectAtIndexPath.unbindAll()
        _didUpdateObjectAtIndexPath.unbindAll()
        _willChangeContent.unbindAll()
        _didChangeContent.unbindAll()
        locationService?.locationServiceUpdatedObservable.unbindAll()
        _didSelectCellAtIndexPath.unbindAll()
        _alertControlleError.unbindAll()
    }
}

extension WeatherListViewModel : HasWeatherFetchResultsController {
    
    func willChangeContent() {
        _willChangeContent.value = ()
    }
    
    func didChangeContent() {
        _didChangeContent.value = ()
    }
    
    func didInsertNewObject(_ object: CoreDataWeatherObjectNotification) {
       
        _didInsertObjectAtIndexPath.value = weatherCellViewNotificationObject(from: object)
    }
    
    func didDeleteObject(_ object: CoreDataWeatherObjectNotification) {
        _didDeleteObjectAtIndexPath.value = weatherCellViewNotificationObject(from: object)
    }
    
    func didMoveObject(_ object: CoreDataWeatherObjectNotification) {
        _didMoveObjectAtIndexPath.value = weatherCellViewNotificationObject(from: object)
    }
    
    func didUpdateObject(_ object: CoreDataWeatherObjectNotification) {
        _didUpdateObjectAtIndexPath.value = weatherCellViewNotificationObject(from: object)
    }
    
    private func weatherCellViewNotificationObject(from notificationObject:CoreDataWeatherObjectNotification) -> WeatherCellViewNotificationObject {
        let weatherCellModel = WeatherCellModel.from(weatherData: notificationObject.object)
        return WeatherCellViewNotificationObject(object: weatherCellModel, indexPath: notificationObject.indexPath, newIndexPath: notificationObject.newIndexPath)
    }
    
    
}
