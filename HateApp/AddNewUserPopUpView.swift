//
//  AddNewUserPopUp.swift
//  HateApp
//
//  Created by Elina Samardjieva on 4/26/16.
//  Copyright © 2016 Elina Samardjieva. All rights reserved.
//

import UIKit

protocol AddNewUserPopUpViewDelegate {
    func addNewUserPopUpViewDidPressedButton(sender: AddNewUserPopUpView)
}

class AddNewUserPopUpView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet var popUpView: UIView!
    @IBOutlet var blurEffectView: UIVisualEffectView!
    
    @IBOutlet var haterNameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var confirmPasswordTextField: UITextField!
    
    @IBOutlet var alertMessageLabel: UILabel!
    @IBOutlet var registerButton: UIButton!
    
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    
    var delegate: AddNewUserPopUpViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        NSBundle.mainBundle().loadNibNamed("AddNewUserPopUpView", owner: self, options: nil)
        popUpView.layer.cornerRadius = 30
        addSubview(contentView)
        
        registerButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        registerButton.backgroundColor = UIColor(white: 0.5, alpha: 0.2)
        registerButton.layer.cornerRadius = 20
        registerButton.layer.borderWidth = 2
        registerButton.layer.borderColor = UIColor(white: 0.5, alpha: 0.4).CGColor
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "hide")
        blurEffectView.addGestureRecognizer(tap)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func show() {
        // MARK: - Show the DatePicker
        blurEffectView.layer.opacity = 0
        
        popUpView.transform = CGAffineTransformMakeTranslation(0, -(CGRectGetHeight(self.popUpView.bounds)))

        UIView.animateWithDuration(0.8, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1, options: .CurveEaseOut, animations:  {
            self.popUpView.transform = CGAffineTransformIdentity
            self.blurEffectView.layer.opacity = 1
        }) { _ in
        }
        UIApplication.sharedApplication().windows.first!.addSubview(self) // On top of everything, everything else is disabled
    }
    
    func hide() {
        UIView.animateWithDuration(0.5,
                                   animations: {
                                    self.popUpView.transform = CGAffineTransformMakeTranslation(0, -(CGRectGetHeight(self.popUpView.bounds)*3))
                                    self.blurEffectView.layer.opacity = 0.3
            }, completion: { (value: Bool) in
                self.removeFromSuperview()
        })
    }
    
    // NB!!!
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = self.bounds
    }
    
    @IBAction func registerHaterButtonPressed(sender: UIButton) {
        if let delegate = delegate {
            delegate.addNewUserPopUpViewDidPressedButton(self)
        }
    }
    
}
