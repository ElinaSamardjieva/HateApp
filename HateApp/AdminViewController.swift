//
//  AdminViewController.swift
//  HateApp
//
//  Created by Elina Samardjieva on 4/25/16.
//  Copyright © 2016 Elina Samardjieva. All rights reserved.
//

import UIKit
import CoreData

class AdminViewController: UIViewController, UITableViewDataSource, AddNewUserPopUpViewDelegate {

    @IBOutlet var usersTableView: UITableView!
       
    override func viewDidLoad() {
        super.viewDidLoad()
        
         print("View did appear called")

        self.view.layoutIfNeeded()
        usersTableView.dataSource = self
        usersTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        usersTableView.separatorStyle = .None
    
        backgroundImageFillScren()
        
//        deleteAllData("User")
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        print("View will appear called")

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
    
    @IBAction func addButtonPressed(sender: AnyObject) {
        let addPopUp = AddNewUserPopUpView.init(frame: UIScreen.mainScreen().bounds)
        addPopUp.delegate = self
        addPopUp.show()
    }
    
    func addNewUserPopUpViewDidPressedButton(sender: AddNewUserPopUpView) {
        
        let userNameInput = sender.haterNameTextField.text!
        let passwordInput = sender.passwordTextField.text!
        let confirmPasswordInput = sender.confirmPasswordTextField.text!
        let alertMessageLabel = sender.alertMessageLabel
        
        var heightConstraint = sender.heightConstraint
        
        let results = DataManager.sharedManager.users.filter { $0.name == userNameInput }
        let isEmpty = results.isEmpty
        
        if !isEmpty {
            alertMessageLabel.text = "The username already exists. Please, try with a different name."
            heightConstraint.constant = 30
        } else if userNameInput == "" {
            alertMessageLabel.text = "The username is empty. Please, try again"
            heightConstraint.constant = 30
        } else if userNameInput.characters.count <= 3 {
            alertMessageLabel.text = "The username must be longer than 3 symbols. Please, try again"
            heightConstraint.constant = 30
        } else if passwordInput != confirmPasswordInput {
            alertMessageLabel.text = "The two passwords do not match. Please, try again."
            heightConstraint.constant = 30
        } else if passwordInput == "" {
            alertMessageLabel.text = "The password cannot be empty. Please, try again."
        }
        else {
            saveUser(sender.haterNameTextField.text!, password: sender.passwordTextField.text!)
            usersTableView.reloadData()
        }
    }
    
    func saveUser(name: String, password: String) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("User", inManagedObjectContext: managedContext)
        let user = User(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
            user.setValue(name, forKey: "name")
            user.setValue(password, forKey: "password")
        
            do {
                try managedContext.save()
                DataManager.sharedManager.users.append(user)

                for user in DataManager.sharedManager.users {
                    print("User ---- > \(user.name)")
                }
                
            } catch let error as NSError {
                print("Error")
        }
    }
    
    // MARK: - TableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.sharedManager.users.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = usersTableView.dequeueReusableCellWithIdentifier("Cell")! as UITableViewCell
        
        cell.selectionStyle = .None
        cell.backgroundColor = UIColor(white: 0.9, alpha: 0.4)
    
        cell.textLabel!.text = DataManager.sharedManager.users[indexPath.row].name
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        
        if editingStyle == .Delete {
            
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                let managedContext = appDelegate.managedObjectContext
                
                let userFromArray = DataManager.sharedManager.users[indexPath.row]
                DataManager.sharedManager.users.removeAtIndex(indexPath.row)
                managedContext.deleteObject(userFromArray)
                
                do {
                    try managedContext.save()
                    print("User deleted")
                    
                } catch let error as NSError {
                    print("Error")
            }
                usersTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    // MARK: - Delete data
    
//    func deleteAllData(entity: String) {
//        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        let managedContext = appDelegate.managedObjectContext
//        let fetchRequest = NSFetchRequest(entityName: entity)
//        fetchRequest.returnsObjectsAsFaults = false
//        
//        do
//        {
//            let results = try managedContext.executeFetchRequest(fetchRequest)
//            for managedObject in results
//            {
//                let managedObjectData: NSManagedObject = managedObject as! NSManagedObject
//                managedContext.deleteObject(managedObjectData)
//            }
//        } catch let error as NSError {
//            print("Error")
//        }
//    }
    
    // MARK: - Background Image
    
    func backgroundImageFillScren() {
        let width = UIScreen.mainScreen().bounds.size.width
        let height = UIScreen.mainScreen().bounds.size.height
        
        let imageViewBackground = UIImageView(frame: CGRectMake(0, 0, width, height))
        imageViewBackground.image = UIImage(named: "adminApple")
        
        // you can change the content mode:
        imageViewBackground.contentMode = UIViewContentMode.ScaleAspectFill
        
        view.addSubview(imageViewBackground)
        view.sendSubviewToBack(imageViewBackground)
    }
    
//    func createAlert(message: String) {
//        let alert = UIAlertController(title: "Try again", message: message, preferredStyle: .Alert)
//        let doneAction = UIAlertAction(title: "Done", style: .Default, handler: { (action: UIAlertAction) -> Void in })
//        alert.addAction(doneAction)
//        presentViewController(alert, animated: true, completion: nil)
//    }
}




//func removeUser(name: String) {
//    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//    let managedContext = appDelegate.managedObjectContext
//    
//    let entity = NSEntityDescription.entityForName("User", inManagedObjectContext: managedContext)
//    let user = User(entity: entity!, insertIntoManagedObjectContext: managedContext)
//    
//    
//    print(users.count)
//    for user in users {
//        print(user.name)
//    }
//    
//    let indexOfPerson = users.filter { $0.name == "Eli" }.first
//    let index = users.indexOf(indexOfPerson!)
//    
//    users.removeAtIndex(index!)
//    
//    print(users.count)
//    for user in users {
//        print(user.name)
//    }
//}


// let index = users.indexOf(indexOfPerson!)
// users.removeAtIndex(index!)

//func removeUser(name: String) {
//    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//    let managedContext = appDelegate.managedObjectContext
//    
//    let fetchRequest = NSFetchRequest(entityName: "User")
//    
//    do {
//        let results = try managedContext.executeFetchRequest(fetchRequest)
//        users = results as! [User]
//        
//    } catch let error as NSError {
//        print("Error")
//    }
//    
//    let userFromArray = users.filter { $0.name == name }.first
//    managedContext.deleteObject(userFromArray!)
//    
//    do {
//        try managedContext.save()
//        print("User deleted")
//        
//    } catch let error as NSError {
//        print("Error")
//    }
//}