//
//  ViewController.swift
//  LoginWindow
//
//  Created by Kory Brown on 7/23/15.
//  Copyright © 2015 Alpha. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var user : Profile?
    var profiles = [Profile]()
    var emailMatch = false
    
    // MARK: Properties
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        if let savedProfiles = loadProfiles() {
            profiles += savedProfiles
        }
        
        printUserLog()
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        
        // Hide keyboard
        
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        return true
    }
    
    // MARK: Action
    
    @IBAction func loginAccess(sender: UIButton) {
        // check for valid login
        user = Profile(email: emailTextField.text!, password: passwordTextField.text!, firstName: nil, lastName: nil, phoneNumber: nil, photo: nil)
        
        for possibleCurrentUser in profiles {
            if user!.email == possibleCurrentUser.email {
                if user!.password == possibleCurrentUser.password {
                    // valid - send to...
                    print("We have a match")
                    user = possibleCurrentUser
                    self.performSegueWithIdentifier("UserMatch", sender: self)
                    return
                }
                else {
                    print("Emails match but password doesn't.... Try again")
                    emailMatch = true
                    return
                }
            }
        }
        // not valid - send to create a profile window
    }
    
    // MARK: Segue
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            print("Fields are empty... Please fill in!")
            return false
        }
        else if emailMatch {
            emailMatch = false
            return false
        }
        else {
            return true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "UserMatch" {
            let navi = segue.destinationViewController as! UINavigationController
            let profileView = navi.viewControllers.first as! ProfileViewController
            
            profileView.currentUser = user
            
        }
        else if segue.identifier == "HomeScreen" {
            
        }
        else {
            let firstScene = segue.destinationViewController as! CreateProfileViewController
            
            firstScene.currentUser = user
            firstScene.profiles = profiles
        }
    }
    
    // MARK: NSCoding
    func loadProfiles() -> [Profile]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Profile.ArchiveURL.path!) as? [Profile]
    }
    
    // MARK: Security Check
    func printUserLog(){
        for profile in profiles {
            print("Email: " + profile.email + "\n" + "Password: " + profile.password)
        }
    }
}

