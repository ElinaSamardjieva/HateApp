//
//  HatersTableViewCell.swift
//  HateApp
//
//  Created by Elina Samardjieva on 5/4/16.
//  Copyright © 2016 Elina Samardjieva. All rights reserved.
//

import UIKit

class HatersTableViewCell: UITableViewCell {

    @IBOutlet var hatersNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor(white: 0.9, alpha: 0.4)
        selectionStyle = .None
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
