//
//  Asset+CoreDataProperties.swift
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

extension Asset {

    @NSManaged var id: Int64
    @NSManaged var tag: String?
    @NSManaged var updated_at: NSTimeInterval
    @NSManaged var created_at: NSTimeInterval
    @NSManaged var state: String?
    @NSManaged var notes: String?
    @NSManaged var labels: NSOrderedSet?
    @NSManaged var photos: NSSet?
    @NSManaged var scans: Scan?

}
