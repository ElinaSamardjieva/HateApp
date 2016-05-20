//
//  VictimsTableViewCell.swift
//  HateApp
//
//  Created by Elina Samardjieva on 5/11/16.
//  Copyright © 2016 Elina Samardjieva. All rights reserved.
//

import UIKit


protocol VictimsTableViewCellDelegate {
    func victimsTableViewCellDidPressedOnePointButton(sender: VictimsTableViewCell)
    func victimsTableViewCellDidPressedTwoPointsButton(sender: VictimsTableViewCell)
}

class VictimsTableViewCell: UITableViewCell {

    @IBOutlet var victimsNameLabel: UILabel!
    @IBOutlet var onePointButton: UIButton!
    @IBOutlet var twoPointsButton: UIButton!
    
    var delegate: VictimsTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor(white: 0.9, alpha: 0.4)
        selectionStyle = .None
        
        customizeButton(onePointButton)
        customizeButton(twoPointsButton)
    }
    
    @IBAction func onePointButtonPressed(sender: UIButton) { // To be delegated methods?
        sender.selected = true
        twoPointsButton.selected = false
        
        if let delegate = delegate {
            delegate.victimsTableViewCellDidPressedOnePointButton(self)
        }
    }
    
    @IBAction func twoPointsButtonPressed(sender: UIButton) {
        sender.selected = true
        onePointButton.selected = false
        
        if let delegate = delegate {
            delegate.victimsTableViewCellDidPressedTwoPointsButton(self)
        }
    }
    
    func customizeButton(button: UIButton) {
        onePointButton.setImage(UIImage(named: "oneunchecked")?.imageWithRenderingMode(.AlwaysOriginal), forState: .Normal)
        twoPointsButton.setImage(UIImage(named: "twounchecked")?.imageWithRenderingMode(.AlwaysOriginal), forState: .Normal)
        onePointButton.setImage(UIImage(named: "onechecked")?.imageWithRenderingMode(.AlwaysOriginal), forState: .Selected)
        twoPointsButton.setImage(UIImage(named: "twochecked")?.imageWithRenderingMode(.AlwaysOriginal), forState: .Selected)
    }
    
    func selectOnePoint(shouldSelect: Bool) {
        onePointButton.selected = shouldSelect
    }
    
    func selectTwoPoints(shouldSelect: Bool) {
        twoPointsButton.selected = shouldSelect
    }
}
