//
//  InvData.swift
//  Inventory
//
//  Created by Tom Seago on 7/6/16.
//  Copyright © 2016 BAAAHS. All rights reserved.
//

import Foundation
import CoreData

class InvData {
    
    lazy var mom : NSManagedObjectModel! = NSManagedObjectModel.mergedModelFromBundles([ NSBundle.mainBundle() ])
    
    lazy var psc : NSPersistentStoreCoordinator! = NSPersistentStoreCoordinator(managedObjectModel: self.mom)
    
    lazy var moc : NSManagedObjectContext! = {
        let moc = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        moc.persistentStoreCoordinator = self.psc
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
            
            let docURL = urls[urls.endIndex-1]
            
            let storeURL = docURL.URLByAppendingPathComponent("DataModel.sqlite")
            do {
                try self.psc.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: nil)
            } catch {
                fatalError("Error migrating store: \(error)")
            }
        }
        
        return moc
    }()
    
    

}

let gInvData = InvData()