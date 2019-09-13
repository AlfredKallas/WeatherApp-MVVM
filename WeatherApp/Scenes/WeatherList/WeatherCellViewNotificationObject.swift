//
//  WeatherCellViewNotificationObject.swift
//  WeatherApp
//
//  Created by Kallas on 9/13/19.
//  Copyright © 2019 AK. All rights reserved.
//

import Foundation

struct WeatherCellViewNotificationObject : NotificationObject {
    typealias T = WeatherCellModel
    var object:T
    var indexPath:IndexPath?
    var newIndexPath:IndexPath?
}
