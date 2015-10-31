//
//  SecondViewController.swift
//  LoginWindow
//
//  Created by Kory Brown on 8/13/15.
//  Copyright © 2015 Alpha. All rights reserved.
//

import UIKit

class SecondViewController: TabVCTemplate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Second View")
    }
    
    @IBAction func toggleMenu(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName("toggleMenu", object: nil)
    }
}
