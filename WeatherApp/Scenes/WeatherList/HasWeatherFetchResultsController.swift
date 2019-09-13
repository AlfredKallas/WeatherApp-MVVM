//
//  HasWeatherFetchResultsController.swift
//  WeatherApp
//
//  Created by Kallas on 9/13/19.
//  Copyright © 2019 AK. All rights reserved.
//

import Foundation

protocol HasWeatherFetchResultsController: class {
    func didInsertNewObject(_ object:CoreDataWeatherObjectNotification)
    func didDeleteObject(_ object:CoreDataWeatherObjectNotification)
    func didMoveObject(_ object:CoreDataWeatherObjectNotification)
    func didUpdateObject(_ object:CoreDataWeatherObjectNotification)
    func willChangeContent()
    func didChangeContent()
}
