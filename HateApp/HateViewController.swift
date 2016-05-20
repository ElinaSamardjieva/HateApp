//
//  HateViewController.swift
//  HateApp
//
//  Created by Elina Samardjieva on 4/22/16.
//  Copyright © 2016 Elina Samardjieva. All rights reserved.
//

import UIKit

class HateViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, VictimsTableViewCellDelegate {

    @IBOutlet var victimTableView: UITableView!
    
    var users = [User]()
    var votes = [Vote]()
    
    var onePoint = 1
    var twoPoints = 2
    var date = NSDate()
    
    var selectedUserWithOnePoint: User?
    var selectedUserWithTwoPoints: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
        
        for vote in votes {
            print(vote.points)
        }
    }
    
    // MARK: - Data
    
    func fetchData() {
        DataManager.sharedManager.fetchUsers()
        users = DataManager.sharedManager.users
        
        DataManager.sharedManager.fetchVotes()
        votes = DataManager.sharedManager.votes
        
        victimTableView.reloadData()
    }
    
    // MARK: - Table View
    
    func configureTableView() {
        victimTableView.dataSource = self
        victimTableView.delegate = self
        victimTableView.registerNib(UINib(nibName: "VictimsTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        victimTableView.separatorStyle = .None
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = victimTableView.dequeueReusableCellWithIdentifier("Cell") as! VictimsTableViewCell!
        
        if indexPath.row < users.count {
            let user = users[indexPath.row]
            cell.victimsNameLabel.text = user.name
            

            cell.selectOnePoint(user.objectID == selectedUserWithOnePoint?.objectID)
            cell.selectTwoPoints(user.objectID == selectedUserWithTwoPoints?.objectID)
        }
        
        cell.delegate = self
        
        return cell
    }
    
    // VictimsTableViewCell Delegate
    
    func victimsTableViewCellDidPressedOnePointButton(sender: VictimsTableViewCell) {
        
        let indexPath = victimTableView.indexPathForCell(sender)
        
        if let indexPath = indexPath {
            if indexPath.row < users.count {
                selectedUserWithOnePoint = users[indexPath.row]
                
                if selectedUserWithOnePoint == selectedUserWithTwoPoints {
                    selectedUserWithTwoPoints = nil
                }
                victimTableView.reloadData()
            }
        }
    }
    
    func victimsTableViewCellDidPressedTwoPointsButton(sender: VictimsTableViewCell) {
        
        let indexPath = victimTableView.indexPathForCell(sender)
        
        if let indexPath = indexPath {
            if indexPath.row < users.count {
                selectedUserWithTwoPoints = users[indexPath.row]
                
                if selectedUserWithTwoPoints == selectedUserWithOnePoint {
                    selectedUserWithOnePoint = nil
                }
                
                victimTableView.reloadData()
            }
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func submitButtonPressed(sender: UIButton) {
        
        print("Hate given")
        DataManager.sharedManager.saveVote(onePoint, date: date, candidate: selectedUserWithOnePoint!)
        DataManager.sharedManager.saveVote(twoPoints, date: date, candidate: selectedUserWithTwoPoints!)
    }
}