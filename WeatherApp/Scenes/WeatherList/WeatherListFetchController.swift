//
//  WeatherListFetchController.swift
//  WeatherApp
//
//  Created by Kallas on 9/12/19.
//  Copyright © 2019 AK. All rights reserved.
//

import Foundation
import CoreData

class WeatherListFetchController: NSObject, NSFetchedResultsControllerDelegate {
    
    weak var fetchControllerObject: HasWeatherFetchResultsController?
    
    init(with fetchControllerObject: HasWeatherFetchResultsController) {
        super.init()
        self.fetchControllerObject = fetchControllerObject

    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard let weatherData = anObject as? WeatherData else { return }
            fetchControllerObject?.didInsertNewObject(CoreDataWeatherObjectNotification(object: weatherData, indexPath: nil, newIndexPath: newIndexPath))
        case .delete:
            guard let weatherData = anObject as? WeatherData else { return }
            fetchControllerObject?.didDeleteObject(CoreDataWeatherObjectNotification(object: weatherData, indexPath: nil, newIndexPath: newIndexPath))
        case .move:
            guard let weatherData = anObject as? WeatherData else { return }
            fetchControllerObject?.didMoveObject(CoreDataWeatherObjectNotification(object: weatherData, indexPath: nil, newIndexPath: newIndexPath))
        case .update:
            guard let weatherData = anObject as? WeatherData else { return }
            fetchControllerObject?.didUpdateObject(CoreDataWeatherObjectNotification(object: weatherData, indexPath: nil, newIndexPath: newIndexPath))
        }
    }
    
    
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        fetchControllerObject?.willChangeContent()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        fetchControllerObject?.didChangeContent()
    }
}


