//
//  CoreDataWeatherObjectNotification.swift
//  WeatherApp
//
//  Created by Kallas on 9/13/19.
//  Copyright © 2019 AK. All rights reserved.
//

import Foundation

struct CoreDataWeatherObjectNotification : CoreDataNotificationObject {
    typealias T = WeatherData
    var object: WeatherData
    var indexPath:IndexPath?
    var newIndexPath:IndexPath?
}
