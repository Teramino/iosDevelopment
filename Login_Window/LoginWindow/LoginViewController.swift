//
//  ViewController.swift
//  LoginWindow
//
//  Created by Kory Brown on 7/23/15.
//  Copyright © 2015 Alpha. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var possibleUser : Profile?
    
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
    @IBAction func loginAccess(sender: UIButton) {
        // check for valid login
        
        // valid - send to...
        
        // not valid - send to create a profile window
        possibleUser = Profile(email: emailTextField.text!, firstName: nil, lastName: nil, password: passwordTextField.text!, phoneNumber: nil, photo: nil)
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        
        if emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            print("Fields are empty... Please fill in!")
            return false
        }
        else {
            return true
        }
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var firstScene = segue.destinationViewController as! CreateProfileViewController
        
        firstScene.currentUser = possibleUser
    }
    
    
    
}

