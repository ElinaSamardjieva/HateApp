//
//  DataManager.swift
//  HateApp
//
//  Created by Elina Samardjieva on 4/25/16.
//  Copyright © 2016 Elina Samardjieva. All rights reserved.
//

import UIKit

private let _sharedInstance = DataManager()

class DataManager: NSObject {
    
    var users = [User]()
    
    class var sharedManager: DataManager {
        return _sharedInstance
    }
}