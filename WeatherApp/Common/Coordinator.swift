//
//  Router.swift
//  WeatherApp
//
//  Created by Kallas on 9/12/19.
//  Copyright © 2019 AK. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator {
    func start()
    var navigationController:UINavigationController? { get set }
    var children:[Coordinator] { get set }
}
