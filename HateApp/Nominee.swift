//
//  Winner.swift
//  HateApp
//
//  Created by Elina Samardjieva on 5/13/16.
//  Copyright © 2016 Elina Samardjieva. All rights reserved.
//

import UIKit
import CoreData


class Nominee: NSObject {

    var id = NSManagedObjectID()
    var points = 0
    var name = ""
    
    convenience init(name: String, id: NSManagedObjectID, points: Int) {
        self.init()
        
        self.name = name
        self.id = id
        self.points = points
    }
}
