//
//  WinnerViewController.swift
//  HateApp
//
//  Created by Elina Samardjieva on 5/19/16.
//  Copyright © 2016 Elina Samardjieva. All rights reserved.
//

import UIKit

class WinnerViewController: UIViewController {
    
    var count = 0
    var delay = 0.0
    var position = CGFloat(1024)
    var size = CGFloat(60)
    var bottomConstraint: NSLayoutConstraint!
    var nominees = DataManager.sharedManager.report.nominees
    
    override func viewDidLoad() {
        super.viewDidLoad()

 //       while count <= DataManager.sharedManager.report.nominees.count - 1 {
        while count <= 4 {
            createCircle(count)
            count += 1
        }
    }
    
    func createCircle(count: Int) {
        print(position)
        print(nominees[count].name)
        
        let circle = UIView(frame: CGRectMake(self.view.frame.size.width / 2 - size / 2, position - size, size, size))
        circle.backgroundColor = UIColor.yellowColor()
        circle.layer.cornerRadius = size / 2
        
        print(count - 2)
        print(nominees.count)
 //       if count < nominees.count - 2 {
//            if nominees[count].points == nominees[count + 1].points {
//                
//                let firstNameLabel = UILabel(frame: CGRectMake(circle.frame.size.width / 2, circle.frame.size.height / 2 - 30, 50, 50))
//                firstNameLabel.textAlignment = NSTextAlignment.Center
//                firstNameLabel.text = nominees[count].name
//                circle.addSubview(firstNameLabel)
//                
//                let secondNameLabel = UILabel(frame: CGRectMake(circle.frame.size.width / 2 - 25, circle.frame.size.height / 2 - 30, 50, 50))
//                secondNameLabel.textAlignment = NSTextAlignment.Center
//                secondNameLabel.text = nominees[count].name
//                circle.addSubview(secondNameLabel)
//                
//            } else {
        
                let nameLabel = UILabel(frame: CGRectMake(circle.frame.size.width / 2 - 25, circle.frame.size.height / 2 - 30, 50, 50))
                nameLabel.textAlignment = NSTextAlignment.Center
                nameLabel.text = nominees[count].name
                circle.addSubview(nameLabel)
            
 //           }
 //       }
        
        let pointsLabel = UILabel(frame: CGRectMake(circle.frame.size.width / 2 - 25, circle.frame.size.height / 2 - 10, 50, 50))
        pointsLabel.textAlignment = NSTextAlignment.Center
        pointsLabel.text = String(nominees[count].points)
        circle.addSubview(pointsLabel)
        
        if count < 4 {
            circle.transform = CGAffineTransformMakeTranslation(0, position + size)
        } else if count ==  4 {
            circle.transform = CGAffineTransformMakeTranslation(0, position - 2000)
        }
        
        UIView.animateWithDuration(1, delay: delay, usingSpringWithDamping: 0.4, initialSpringVelocity: 1, options: .CurveEaseOut, animations:{
                circle.transform = CGAffineTransformIdentity
            }) { _ in
        }
        
        view.addSubview(circle)
        
        delay += 1.5
        position -= size // the position where the circle will return. 1024 - 100. the distance between the circles
        size *= 1.5
    }
}