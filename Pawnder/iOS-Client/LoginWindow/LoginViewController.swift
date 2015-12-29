//
//  ViewController.swift
//  LoginWindow
//
//  Created by Kory Brown on 7/23/15.
//  Copyright © 2015 Alpha. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var user : Profile?
    var profiles : [Profile]? = [Profile]()
    var emailMatch = false
    
    // MARK: Properties
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        // not needed anymore; built a search engine
        if let savedProfiles = loadProfiles() {
            profiles? += savedProfiles
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
    
    @IBAction func loginAccess(sender: AnyObject) {
        
        var password = passwordTextField.text
        var email = emailTextField.text
        var finalEmail = email!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        // Validate the text field
        
        // ==============================================================
        // looking to access password
        if password!.characters.count < 8 {
            var alert = UIAlertView(title: "Invalid", message: "Password must be greater than 8 characters", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        }
            //        else if email?.characters.count < 8 {
            //            var alert = UIAlertView(title: "Invalid", message: "Please enter a valid email address", delegate: self, cancelButtonTitle: "OK")
            //            alert.show()
            //
            //        }
        else
        {
            // Run a spinner to show a task in progress
            var spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
            spinner.startAnimating()
            
            // Send a request to login
            PFUser.logInWithUsernameInBackground(email!, password: password!, block: { (user, error) -> Void in
                
                // Stop the spinner
                spinner.stopAnimating()
                
                if ((user) != nil) {
                    var alert = UIAlertView(title: "Success", message: "Logged In", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    
                    // switch to homescreen
                    //self.performSegueWithIdentifier("UserMatch", sender: self)
                    //                                return
                    
                    //                                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    //                                    let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Home") as! UIViewController
                    //                                    self.presentViewController(viewController, animated: true, completion: nil)
                    //                                })
                    
                    
                    
                    // checked cloud database for user
                    var query = PFQuery(className: "Users")
                    query.whereKey("email", equalTo: email!)
                    // similar to if check for matching emails
                    query.whereKey("password", equalTo: password!)
                    
                    query.getFirstObjectInBackgroundWithBlock
                        {
                            (object: PFObject?, error: NSError?) -> Void in
                            // no user found create a new one
                            if error != nil || object == nil
                            {
                                print("New user")
                                
                                // switch to create profile view
                            }
                            else
                            {
                                // The find succeeded.
                                print("Returning user")
                            }
                    }
                    
                    
                }
                else
                {
                    var alert = UIAlertView(title: "Login Unsuccessful", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                }
            })
            
        }
        user = Profile(email: emailTextField.text!, password: passwordTextField.text!, firstName: nil, lastName: nil, phoneNumber: nil, photo: nil)
        
        // check for valid login on device
        for possibleCurrentUser in profiles!
        {
            // checked device for user
            if user!.email == possibleCurrentUser.email
            {
                if user!.password == possibleCurrentUser.password
                {
                    // valid - send to...
                    print("We have a match")
                    user = possibleCurrentUser
                    self.performSegueWithIdentifier("UserMatch", sender: self)
                    return
                }
                else
                {
                    print("Emails match but password doesn't.... Try again")
                    emailMatch = true
                    return
                }
            }
        }
        // not valid - send to create a profile window
    }
    
    // MARK: Segue
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool
    {
        if emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty
        {
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
            firstScene.profiles = profiles!
        }
    }
    
    // MARK: NSCoding
    func loadProfiles() -> [Profile]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Profile.ArchiveURL.path!) as? [Profile]
    }
    
    // MARK: Security Check
    func printUserLog(){
        for profile in profiles! {
            print("Email: " + profile.email + "\n" + "Password: " + profile.password)
        }
    }
}

