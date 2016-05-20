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
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    // MARK: - Data
    
    func fetchData() {
        DataManager.sharedManager.fetchUsers()
        users = DataManager.sharedManager.users
        usersTableView.reloadData()
    }
    
    // MARK: - Actions
    
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
            sender.hide()
        }
    }
    
    func saveUser(name: String, password: String) {
        DataManager.sharedManager.saveUser(name, password: password)
    }
    
    // MARK: - TableView
    
    func configureTableView() {
        usersTableView.registerNib(UINib(nibName: "HatersTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        usersTableView.dataSource = self
        usersTableView.separatorStyle = .None
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
      //  return DataManager.sharedManager.visibleUsersArray.count
        return DataManager.sharedManager.users.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = usersTableView.dequeueReusableCellWithIdentifier("Cell") as! HatersTableViewCell!
    
        
       // if indexPath.row < DataManager.sharedManager.visibleUsersArray.count {
        if indexPath.row < DataManager.sharedManager.users.count {
        
      //  cell.hatersNameLabel.text = DataManager.sharedManager.visibleUsersArray[indexPath.row].name
            cell.hatersNameLabel.text = DataManager.sharedManager.users[indexPath.row].name
            
        }
        return cell
    }
    
    // MARK: - Delete cell
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
            if editingStyle == .Delete {
             //   DataManager.sharedManager.deleteUser(DataManager.sharedManager.visibleUsersArray[indexPath.row], index: indexPath.row)
                DataManager.sharedManager.deleteUser(DataManager.sharedManager.users[indexPath.row], index: indexPath.row)
            }
        
        usersTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }