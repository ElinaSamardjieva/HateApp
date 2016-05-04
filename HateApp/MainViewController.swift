//
//  ViewController.swift
//  HateApp
//
//  Created by Elina Samardjieva on 4/22/16.
//  Copyright © 2016 Elina Samardjieva. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UIViewController, AuthenticatePopUpDelegate {
    
    @IBOutlet var hateButton: UIButton!
    @IBOutlet var adminButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backgroundImageFillScren()
        hateButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        hateButton.backgroundColor = UIColor(white: 0.5, alpha: 0.2)
        hateButton.layer.cornerRadius = 20
        hateButton.layer.borderWidth = 2
        hateButton.layer.borderColor = UIColor(white: 0.5, alpha: 0.4).CGColor
        
        adminButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        adminButton.backgroundColor = UIColor(white: 0.5, alpha: 0.2)
        adminButton.layer.cornerRadius = 20
        adminButton.layer.borderWidth = 2
        adminButton.layer.borderColor = UIColor(white: 0.5, alpha: 0.4).CGColor
        
        navigationController!.navigationBar.barTintColor = UIColor.blackColor()
        navigationController!.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
                print("HERE")
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "User")
        
                do {
                    let results =
                        try managedContext.executeFetchRequest(fetchRequest)
        
                    DataManager.sharedManager.users = results as! [User]
        
                    print("Users ---->")
                    for user in DataManager.sharedManager.users {
        
                        print(user.name)
                    }
                } catch let error as NSError {
                    print("Error")
                }
    }
    
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        print("HERE")
//        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        let managedContext = appDelegate.managedObjectContext
//        
//        let fetchRequest = NSFetchRequest(entityName: "User")
//        
//        do {
//            let results =
//                try managedContext.executeFetchRequest(fetchRequest)
//            
//            DataManager.sharedManager.users = results as! [User]
//            
//            print("Users ---->")
//            for user in DataManager.sharedManager.users {
//                
//                print(user.name)
//            }
//        } catch let error as NSError {
//            print("Error")
//        }
//    }
    
    func backgroundImageFillScren() {
        let width = UIScreen.mainScreen().bounds.size.width
        let height = UIScreen.mainScreen().bounds.size.height
        
        let imageViewBackground = UIImageView(frame: CGRectMake(0, 0, width, height))
        imageViewBackground.image = UIImage(named: "burningApple.jpeg")
        
        imageViewBackground.contentMode = UIViewContentMode.ScaleAspectFill
        
        view.addSubview(imageViewBackground)
        view.sendSubviewToBack(imageViewBackground)
    }
    
    @IBAction func hateButtonPressed(sender: UIButton) {
        let popUpView = AuthenticatePopUpView.init(frame: UIScreen.mainScreen().bounds)
        popUpView.delegate = self
        popUpView.show()
    }
    
    @IBAction func adminButtonPressed(sender: UIButton) {
        
        let mapViewControllerObj = self.storyboard?.instantiateViewControllerWithIdentifier("AdminViewController") as? AdminViewController
        self.navigationController?.pushViewController(mapViewControllerObj!, animated: true)
        
    }
    
    func authenticatePopUpViewDidPressedButton(sender: AuthenticatePopUpView) {
        
        
        // HERE 
        
        print(sender.passwordTextField.text)
        var usersPaswword = ""
        
        if sender.currentUser == nil {
            sender.currentUser = DataManager.sharedManager.users[0].name
        }
        
        print(sender.currentUser)
        
        var myCurrentRow = sender.currentRow
        
        if myCurrentRow == nil {
            usersPaswword = DataManager.sharedManager.users[0].password!
        }
        
        usersPaswword = DataManager.sharedManager.users[myCurrentRow].password!
        print(usersPaswword)
        
        if sender.passwordTextField.text == usersPaswword {
        let mapViewControllerObj = self.storyboard?.instantiateViewControllerWithIdentifier("HateViewController") as? HateViewController
        self.navigationController?.pushViewController(mapViewControllerObj!, animated: true)
        } else {
           // sender.heightConstraint.constant = 30
            sender.alertMessageLabel.text = "The password does not match. Please, try again."
        }
    }
}