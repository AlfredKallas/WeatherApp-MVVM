//
//  NotificationObject.swift
//  WeatherApp
//
//  Created by Kallas on 9/13/19.
//  Copyright © 2019 AK. All rights reserved.
//

import Foundation

protocol NotificationObject {
    associatedtype T
    var object:T { get set }
    var indexPath:IndexPath? { get set }
    var newIndexPath:IndexPath? { get set }
}
