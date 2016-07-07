//
//  Scan+CoreDataProperties.swift
//  
//
//  Created by Tom Seago on 7/6/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Scan {

    @NSManaged var id: Int64
    @NSManaged var latitude: Double
    @NSManaged var longitude: Double
    @NSManaged var accuracy: Double
    @NSManaged var altitude: Double
    @NSManaged var altitude_accuracy: Double
    @NSManaged var created_at: NSTimeInterval
    @NSManaged var updated_at: NSTimeInterval
    @NSManaged var photos: NSSet?
    @NSManaged var asset: NSManagedObject?
    @NSManaged var user: User?
    @NSManaged var event: NSManagedObject?

}
