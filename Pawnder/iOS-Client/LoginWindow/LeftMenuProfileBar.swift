//
//  LeftMenuProfileBar.swift
//  LoginWindow
//
//  Created by Joel Bateman on 11/11/15.
//  Copyright © 2015 Alpha. All rights reserved.
//

import UIKit

class LeftMenuProfileBar : UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var userNameButton: UIButton!
    
    // Security Thought - Save this to private manager class in the future
    var currentUser : Profile?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call set button text for UserNameButton
        userNameButton.setTitle(getUserName(), forState: UIControlState.Normal)
    }
    
    // MARK: Actions
    @IBAction func signOutButtonClicked(sender: UIButton) {
        print("Signout Button Clicked")
    }

    
    @IBAction func userNameButtonClicked(sender: AnyObject) {
        print("Username Button Clicked")
        NSNotificationCenter.defaultCenter().postNotificationName("openWindow", object: nil)
    }

    // Retuns the first and last name of User currently logged in
    func getUserName() -> String {
        
        let userName = "Joel Bateman"
        
        return userName
    }
}