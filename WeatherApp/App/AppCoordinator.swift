//
//  AppCoordinator.swift
//  WeatherApp
//
//  Created by Kallas on 9/12/19.
//  Copyright © 2019 AK. All rights reserved.
//

import Foundation
import UIKit

protocol WeatherListCoordinator: class {
    func goToDetails(weatherDetailsModel: WeatherDetailsModel)
}

class AppCoordiantor: Coordinator, WeatherListCoordinator {
    
    var navigationController: UINavigationController?
    
    var children: [Coordinator]
    
    private var weatherListViewController: WeatherListViewController?
    private let window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
        children = [Coordinator]()
    }
    
    func start() {
        let weatherListViewController = WeatherListViewController.makeFromStoryboard()
        let weatherLocationService = WeatherLocationService()
        let weatherListViewModel = WeatherListViewModel(locationService: weatherLocationService)
        
        weatherListViewController.weatherListViewModel = weatherListViewModel
        let fetchController = WeatherListFetchController(with: weatherListViewModel)
        
        weatherListViewModel.weatherListFetchController = fetchController
        
        weatherListViewController.coordiantor = self
        
        
        self.weatherListViewController = weatherListViewController
        
        navigationController = UINavigationController(rootViewController: weatherListViewController)
        
        
        window?.rootViewController = navigationController
        
        window?.makeKeyAndVisible()
        
    }
    
    func goToDetails(weatherDetailsModel: WeatherDetailsModel){
            let weatherDetailsViewController = WeatherDetailsViewController.makeFromStoryboard()
            weatherDetailsViewController.weatherDetailsModel = weatherDetailsModel
            let weatherDetailsViewModel = WeatherDetailsViewModel(weatherDetailsModel: weatherDetailsModel)
            weatherDetailsViewController.weatherDetailsViewModel = weatherDetailsViewModel
        
            navigationController?.pushViewController(weatherDetailsViewController, animated: true)
    }
}
