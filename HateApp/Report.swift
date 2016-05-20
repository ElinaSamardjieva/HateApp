//
//  Report.swift
//  HateApp
//
//  Created by Elina Samardjieva on 5/13/16.
//  Copyright © 2016 Elina Samardjieva. All rights reserved.
//

import UIKit

class Report: NSObject {

    var initialDate: NSDate!
    var finalDate: NSDate!
    var nominees = [Nominee]()
    var winner = Nominee()
    
    convenience init(initialDate: NSDate, finalDate: NSDate, nominees: [Nominee], winner: Nominee) {
        self.init()
        
        self.initialDate = initialDate
        self.finalDate = finalDate
        self.nominees = nominees
        self.winner = winner
    }
    
}
