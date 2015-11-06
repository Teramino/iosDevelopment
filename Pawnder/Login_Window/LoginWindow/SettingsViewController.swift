//
//  SettingsViewController.swift
//  LoginWindow
//
//  Created by Joel Bateman on 11/5/15.
//  Copyright © 2015 Alpha. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: Properties
    var currentUser : Profile?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: Actions
    @IBAction func doneButton(sender: UIButton) {
            dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func logoutButton(sender: AnyObject) {
        print("Logout Action")
    }
    
    
    @IBAction func deleteProfileButton(sender: AnyObject) {
        print("Delete Profile Action")
    }
}
