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
    
    var currentUser : Profile?
    var profiles : [Profile]? = [Profile]()
    var emailMatch = false
    
    // MARK: Properties
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        
        // Hide keyboard
        
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        return true
    }
    
    // MARK: Action
    //sends to profileviewwindow or creatprofileviewwindow
    @IBAction func loginAccess(sender: AnyObject)
    {
        
        var password = passwordTextField.text
        var email = emailTextField.text
        var finalEmail = email!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        // Validate the text field
        
        // ==============================================================
        // looking to access password
        if password!.characters.count < 8
        {
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
            PFUser.logInWithUsernameInBackground(email!, password: password!, block:
                { (user, error) -> Void in
                
                // Stop the spinner
                spinner.stopAnimating()
                
                if ((user) != nil)
                {
                    var alert = UIAlertView(title: "Success", message: "Logged In", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    
                    
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
                        {(object: PFObject?, error: NSError?) -> Void in
                            
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
                                
                                // pull data from database
                                print(object?.objectId)
                                let email = object!["email"] ?? "no data"
                                let password = object!["password"] ?? "no data"
                                let firstName = object!["firstName"] ?? "no data"
                                let lastName = object!["lastName"] ?? "no data"
                                let phoneNumber = object!["phoneNumber"] ?? "no data"
                                
                                self.currentUser = Profile()
                                
                                self.currentUser?.email = email as! String
                                print(self.currentUser?.email)
                                self.currentUser?.password = password as! String
                                self.currentUser?.firstName = firstName as! String
                                self.currentUser?.lastName = lastName as! String
                                self.currentUser?.phoneNumber = phoneNumber as! String
                                
                                self.performSegueWithIdentifier("UserMatch", sender: self)
                                return
                                
                            }
                    }
                }
                else
                {
                    let alert = UIAlertView(title: "Login Unsuccessful", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                }
            })
            
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
            
            profileView.currentUser = currentUser
            
        }
        else if segue.identifier == "HomeScreen" {
            
        }
        else {
            let firstScene = segue.destinationViewController as! CreateProfileViewController
            
            firstScene.currentUser = currentUser
            firstScene.profiles = profiles!
        }
    }
    
    // MARK: Security Check
    func printUserLog(){
        for profile in profiles! {
            print("Email: " + profile.email + "\n" + "Password: " + profile.password)
        }
    }
}

