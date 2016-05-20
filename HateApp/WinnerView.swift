//
//  WinnerView.swift
//  HateApp
//
//  Created by Elina Samardjieva on 5/17/16.
//  Copyright © 2016 Elina Samardjieva. All rights reserved.
//

import UIKit

class WinnerView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet var topView: UIView!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var pointsLabel: UILabel!
    
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var widthConstraint: NSLayoutConstraint!
    @IBOutlet var bottomConstraint: NSLayoutConstraint!
    
    var sizes = 200
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        NSBundle.mainBundle().loadNibNamed("WinnerView", owner: self, options: nil)
        
        addSubview(contentView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show() {
        UIApplication.sharedApplication().windows.first!.addSubview(self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = self.bounds
        
        topView.layer.cornerRadius = CGRectGetHeight(topView.bounds) / 2.0
    }
}
