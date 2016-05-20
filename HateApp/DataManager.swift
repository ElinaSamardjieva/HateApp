//
//  DataManager.swift
//  HateApp
//
//  Created by Elina Samardjieva on 4/25/16.
//  Copyright © 2016 Elina Samardjieva. All rights reserved.
//

import UIKit
import CoreData

private let _sharedInstance = DataManager()

class DataManager: NSObject {
    
    var users = [User]()
    var votes = [Vote]()
    var sortedArray = [Nominee]()
    let report = Report()
    
    var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var managedContext: NSManagedObjectContext {
        get {
            return appDelegate.managedObjectContext
        }
    }
    
    class var sharedManager: DataManager {
        return _sharedInstance
    }
    
    func fetchUsers() -> [User] {
        
//        for user in users {
//            if user.isVisible == true {
//                if !visibleUsersArray.contains(user) {
//                    visibleUsersArray.append(user)
//                }
//            }
//        }
        
        let fetchRequest = NSFetchRequest(entityName: "User")
                
        let predicate = NSPredicate(format: "isVisible == %@", true)
        fetchRequest.predicate = predicate
        
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
                users = results as! [User]
            
                return users
        } catch let error as NSError {
            print("Error: \(error.localizedDescription)")
        }
        print("Here")

        return [User]()
    }
    
    func fetchVotes() -> [Vote] {
        
        let fetchRequest = NSFetchRequest(entityName: "Vote")
        
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            votes = results as! [Vote]
            return votes
        } catch let error as NSError {
            print("Error: \(error.localizedDescription)")
        }
        
        return [Vote]()
    }
    
    func saveUser(name: String, password: String) {
        
        let entity = NSEntityDescription.entityForName("User", inManagedObjectContext: managedContext)
        let user = User(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        user.setValue(name, forKey: "name")
        user.setValue(password, forKey: "password")
        user.setValue(true, forKey: "isVisible")
        
        do {
            try managedContext.save()
            users.append(user)
            
            for user in users {
                print("User ---- > \(user.name)")
            }
            
        } catch let error as NSError {
            print("Error")
        }
        
        print("Total users---> \(users.count)")
    }
    
    func deleteUser(user: User, index: Int) {
        
        user.isVisible = false
        users[index].isVisible = false
        // visibleUsersArray.removeAtIndex(index)
        users.removeAtIndex(index)
        
        do {
            try managedContext.save()
            
            print("User deleted")

      //      fetchUsers()
        } catch let error as NSError {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    
    func saveVote(points: Int, date: NSDate, candidate: User) {
        
        let entity = NSEntityDescription.entityForName("Vote", inManagedObjectContext: managedContext)
        let vote = Vote(entity: entity!, insertIntoManagedObjectContext:  managedContext)
        
        
        vote.setValue(points, forKey: "points")
        vote.setValue(date, forKey: "date")
        vote.setValue(candidate, forKey: "candidate")
        
        do {
            try managedContext.save()
            votes.append(vote)
            
        } catch let error as NSError {
            print("Error: \(error.localizedDescription)")
            }
        }
    
    func prepareReport(initialDate: NSDate, finalDate: NSDate) -> Report? {
        
        let predicate = NSPredicate(format: "date >= %@ && date =< %@", initialDate, finalDate)
        
        let fetchRequest = NSFetchRequest(entityName: "Vote")
        fetchRequest.predicate = predicate
        
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            votes = results as! [Vote]
            
       //     let report = Report()
            report.initialDate = initialDate
            report.finalDate = finalDate

            for vote in votes {
                let candidate = vote.candidate
                if let candidate = candidate {
                    
                    if let points = vote.points {
                    
                        if let nominee = getNomineeForUser(candidate, existingNominees: report.nominees) {
                            nominee.points = nominee.points + Int(points.intValue)
                            
                        } else {
                            var nominee = Nominee()
                            nominee.id = candidate.objectID
                            nominee.name = candidate.name!
                            nominee.points = Int(points.intValue)
                            report.nominees.append(nominee)
                        }
                    }
                }
            }
            
            sortedArray = report.nominees.sort { (element1, element2) -> Bool in
                return element1.points > element2.points
            }
            
            report.nominees = sortedArray.reverse()
            
            for user in sortedArray {
                print("Name ---> \(user.name)")
                print("Points ---> \(user.points)")
            }
            return report
            
        } catch let error as NSError {
            print("Error: \(error.localizedDescription)")
        }
        // return nil
        return nil
    }
    
    func getNomineeForUser(user: User, existingNominees: [Nominee]) -> Nominee? {
        for nominee in existingNominees {
            if nominee.id == user.objectID {
                return nominee
            }
        }
        
        return nil
    }
}





















//        for user in users {
//            if user.name == candidate.name {
//
//                for voteX in votes {
//                    allPoints += Int(vote.points!)
//                }
//            }
//        }
//
//        var winner = Winner(name: candidate.name!, id: candidate.objectID, points: allPoints)
//        print("Winner ----> \(winner.name)")
//        print("Points ----> \(winner.points)")