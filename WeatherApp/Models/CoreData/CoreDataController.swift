//
//  CoreDataStack.swift
//  WeatherApp
//
//  Created by Kallas on 9/10/19.
//  Copyright © 2019 AK. All rights reserved.
//

import Foundation
import MagicalRecord

class CoreDataController {
    
    private init() {}
    static let shared = CoreDataController()
    
    lazy var mainContext = NSManagedObjectContext.mr_default()
    
    func setupCoreData() {
        MagicalRecord.setupCoreDataStack(withStoreNamed: "WeatherApp")
    }
    
    func saveData(saveBlock: @escaping (NSManagedObjectContext) -> ()){
        // Creates a task with a new background context created on the fly
        mainContext.mr_save({ (context) in
                saveBlock(context)
        })
    }
    
}
