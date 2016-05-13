//
//  CircleViewController.swift
//  CircleTransition
//
//  Created by mc373 on 13.05.16.
//  Copyright © 2016 mc373. All rights reserved.
//

import UIKit

class CircleViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    @IBAction func circleTapped(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }

}
