//
//  Vote+CoreDataProperties.swift
//  HateApp
//
//  Created by Elina Samardjieva on 5/16/16.
//  Copyright © 2016 Elina Samardjieva. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Vote {

    @NSManaged var date: NSDate?
    @NSManaged var points: NSNumber?
    @NSManaged var candidate: User?
    @NSManaged var hater: User?

}
