//
//  AuthenticatePopUp.swift
//  HateApp
//
//  Created by Elina Samardjieva on 4/22/16.
//  Copyright © 2016 Elina Samardjieva. All rights reserved.
//

import UIKit

protocol AuthenticatePopUpDelegate {
    func authenticatePopUpViewDidPressedButton(sender: AuthenticatePopUpView)
}

class AuthenticatePopUpView: UIView, UIPickerViewDataSource,UIPickerViewDelegate {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet var popUpView: UIView!
    @IBOutlet var blurEffectView: UIVisualEffectView!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var alertMessageLabel: UILabel!
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    
    @IBOutlet var hatersPickerView: UIPickerView!
    
    var delegate: AuthenticatePopUpDelegate?
    var currentUser: String!
    var currentPassword: String!
    var currentRow: Int!
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        NSBundle.mainBundle().loadNibNamed("AuthenticatePopUpView", owner: self, options: nil)
        
        popUpView.backgroundColor = UIColor(white: 0.5, alpha: 0.4)
        popUpView.layer.cornerRadius = 30
        
        addSubview(contentView)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "hide")
        blurEffectView.addGestureRecognizer(tap)
        
        // Make bottom border on TextField
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRectMake(0.0, passwordTextField.frame.size.height - 1, passwordTextField.frame.size.width, 1.0);
        bottomBorder.backgroundColor = UIColor.blackColor().CGColor
        passwordTextField.layer.addSublayer(bottomBorder)
        passwordTextField.backgroundColor = UIColor.clearColor()
        
        hatersPickerView.dataSource = self
        hatersPickerView.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // NB!!!
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = self.bounds
    }
    
    func show() {
        // MARK: - Show the DatePicker
        popUpView.transform = CGAffineTransformMakeTranslation(0, -(CGRectGetHeight(self.popUpView.bounds)))
        blurEffectView.layer.opacity = 0
        
        
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
    
    @IBAction func enterButtonPressed(sender: UIButton) {
        if let delegate = delegate {
            delegate.authenticatePopUpViewDidPressedButton(self)
        }
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return DataManager.sharedManager.users.count
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return DataManager.sharedManager.users[row].name
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        print(DataManager.sharedManager.users[row].name)
        currentUser = DataManager.sharedManager.users[row].name
        currentPassword = DataManager.sharedManager.users[row].password
    }
}
