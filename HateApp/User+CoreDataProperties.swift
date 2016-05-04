//
//  User+CoreDataProperties.swift
//  HateApp
//
//  Created by Elina Samardjieva on 4/22/16.
//  Copyright © 2016 Elina Samardjieva. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension User {

    @NSManaged var name: String?
    @NSManaged var password: String?

}
