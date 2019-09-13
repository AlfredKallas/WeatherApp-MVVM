//
//  LocationService.swift
//  WeatherApp
//
//  Created by Kallas on 9/11/19.
//  Copyright © 2019 AK. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationService {
    
    func setup()
    
    var locationManager : CLLocationManager? { get set }
        
    var locationServiceUpdatedObservable:Observable<[CLLocation]>! { get }
    
    var locationServiceNotAllowedObservable: Observable<Void>! { get }


}

class WeatherLocationService: NSObject, LocationService, CLLocationManagerDelegate {
    
    var locationServiceUpdatedObservable: Observable<[CLLocation]>! = Observable()
    
    var locationServiceNotAllowedObservable: Observable<Void>! = Observable()
    
    var locationManager: CLLocationManager?
    
    func setup() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.distanceFilter = kCLDistanceFilterNone
        locationManager?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            // Request when-in-use authorization initially
            locationManager?.requestWhenInUseAuthorization()
            break
            
        case .restricted, .denied:
            // Disable location features
            locationManager?.stopUpdatingLocation()
            locationServiceNotAllowedObservable.value = ()
            break
            
        case .authorizedWhenInUse, .authorizedAlways:
            // Enable location features
            locationManager?.startUpdatingLocation()
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        return self.locationServiceUpdatedObservable.value = locations
    }
}
