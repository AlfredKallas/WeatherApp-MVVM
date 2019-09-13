//
//  ViewControllerExtension.swift
//  WeatherApp
//
//  Created by Kallas on 9/12/19.
//  Copyright © 2019 AK. All rights reserved.
//

import Foundation
import UIKit


protocol StoryboardInstantiable {
    
    static var storyboardName: String { get }
    static var storyboardBundle: Bundle? { get }
}

extension StoryboardInstantiable {
    
    static var storyboardBundle: Bundle? { return nil }
    static var storyboardName:String { return "Main"}
    
    static func makeFromStoryboard(With storyboardIdentifier: String = String(describing: Self.self)) -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: storyboardBundle)
        return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! Self
    }
}

extension UIViewController {
    static func initFromStoryBaord<T:UIViewController>(With identifier: String = String(describing: self)) -> T {
        let mainStroyBoard = UIStoryboard(name: "Main", bundle: nil)
        return mainStroyBoard.instantiateViewController(withIdentifier: identifier) as! T
        
    }
}
