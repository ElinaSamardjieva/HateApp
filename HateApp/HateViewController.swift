//
//  HateViewController.swift
//  HateApp
//
//  Created by Elina Samardjieva on 4/22/16.
//  Copyright © 2016 Elina Samardjieva. All rights reserved.
//

import UIKit

class HateViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        backgroundImageFillScren()
    }

    func backgroundImageFillScren() {
        let width = UIScreen.mainScreen().bounds.size.width
        let height = UIScreen.mainScreen().bounds.size.height
        
        let imageViewBackground = UIImageView(frame: CGRectMake(0, 0, width, height))
        imageViewBackground.image = UIImage(named: "burningApple.jpeg")
        
        // you can change the content mode:
        imageViewBackground.contentMode = UIViewContentMode.ScaleAspectFill
        
        view.addSubview(imageViewBackground)
        view.sendSubviewToBack(imageViewBackground)
    }
}
