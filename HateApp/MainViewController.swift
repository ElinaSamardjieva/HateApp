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
    
    @IBOutlet var initialDatePicker: UIDatePicker!
    @IBOutlet var finalDatePicker: UIDatePicker!
    
    @IBOutlet var reportTableView: UITableView!
    
    var initialDate = NSDate()
    var finalDate = NSDate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
//        deleteAllData("Vote")
//        deleteAllData("User")

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchData()
    }
    
    func fetchData() {
        DataManager.sharedManager.fetchUsers()
    }
    
    
    // Actions
    
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
        
        print(sender.passwordTextField.text)
        var usersPaswword = ""
        
        if sender.currentPassword == nil {
            usersPaswword = DataManager.sharedManager.users[0].password!
        } else {
            print("password: \(sender.currentPassword)")
            usersPaswword = sender.currentPassword
        }
        
        if sender.passwordTextField.text == usersPaswword {
            sender.hide()
            let mapViewControllerObj = self.storyboard?.instantiateViewControllerWithIdentifier("HateViewController") as? HateViewController
            self.navigationController?.pushViewController(mapViewControllerObj!, animated: true)
            
        } else {
            sender.heightConstraint.constant = 60
            sender.alertMessageLabel.text = "The password does not match. Please, try again."
        }
    }
    
    @IBAction func reportButtonPressed(sender: UIButton) {
        
        DataManager.sharedManager.prepareReport(initialDate, finalDate: NSDate())
        
        let mapViewControllerObj = self.storyboard?.instantiateViewControllerWithIdentifier("WinnerViewController") as? WinnerViewController
        navigationController?.pushViewController(mapViewControllerObj!, animated: true)
        
      //  let initialDate = NSDate(timeInterval: 60*60*24*2*(-1), sinceDate: NSDate())
//        print("Report given")
//        
//        DataManager.sharedManager.prepareReport(initialDate, finalDate: NSDate())
//        
//        var count = 0
//        var colors = [UIColor.greenColor(), UIColor.blueColor(), UIColor.yellowColor(), UIColor.redColor(), UIColor.purpleColor()]
//
//        var sizes = 100
//        var distance = 0
//        var speed = 0.0
//        
//        while count <= DataManager.sharedManager.report.nominees.count - 1 {
//            
//            let winnerView = WinnerView.init(frame: UIScreen.mainScreen().bounds)
//            
//            winnerView.transform = CGAffineTransformMakeTranslation(0, -(CGRectGetHeight(winnerView.bounds)))
//            
//            UIView.animateWithDuration(speed, animations:  {
//                winnerView.transform = CGAffineTransformIdentity
//            }) { _ in
//            }
//            
//            speed = speed + 1
//            winnerView.topView.backgroundColor = colors[count]
//            winnerView.heightConstraint.constant = CGFloat(sizes)
//            winnerView.widthConstraint.constant = CGFloat(sizes)
//            winnerView.bottomConstraint.constant = CGFloat(distance)
//            
//            if count == DataManager.sharedManager.report.nominees.count - 1 {
//                winnerView.heightConstraint.constant = 400
//                winnerView.widthConstraint.constant = 400
//            }
//
//            winnerView.nameLabel.text = DataManager.sharedManager.report.nominees[count].name
//            winnerView.pointsLabel.text = String(DataManager.sharedManager.report.nominees[count].points)
//            winnerView.show()
//            
//            sizes += 5
//            distance += 100
//            count += 1
//        }
    }
    
    @IBAction func datePickerChanged(sender: UIDatePicker) {
        
        if sender == initialDatePicker {
            initialDate = sender.date
            print(initialDate)
        } else if sender == finalDatePicker {
            finalDate = sender.date
            print(finalDate)
        }
    }
    
    
    func deleteAllData(entity: String) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        
        do
        {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            for managedObject in results {
                let managedObjectData: NSManagedObject = managedObject as! NSManagedObject
                managedContext.deleteObject(managedObjectData)
            }
        } catch let error as NSError {
            print("Delete all data error")
        }
        
        do {
            try managedContext.save()
            print("User deleted")
        } catch let error as NSError {
            print("Error: \(error.localizedDescription)")
        }
    }
}