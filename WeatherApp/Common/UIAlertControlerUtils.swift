//
//  UIAlertControlerUtils.swift
//  WeatherApp
//
//  Created by Kallas on 9/11/19.
//  Copyright © 2019 AK. All rights reserved.
//

import Foundation

import UIKit

extension UIAlertController {
    class func show(_ message: String, buttonTitle:String, from controller: UIViewController?) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default))
        controller?.present(alert, animated: true, completion: nil)
    }
}
