//
//  Photo+CoreDataProperties.swift
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

extension Photo {

    @NSManaged var id: Int64
    @NSManaged var created_at: NSTimeInterval
    @NSManaged var updated_at: NSTimeInterval
    @NSManaged var asset: NSManagedObject?
    @NSManaged var scan: NSManagedObject?

}
