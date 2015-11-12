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
    // Security Thought - Save this to private manager class in the future
    var currentUser : Profile?
    @IBOutlet weak var userNameButton: UIButton!
    var firstName = "User"
    var lastName = "Name"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Changes firstName varible to User's first name
        firstName = (currentUser?.firstName)!
        // Changes lastName varible to User's last name
        lastName = (currentUser?.lastName)!
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
        let userName = firstName + " " + lastName
        
        return userName
    }
}