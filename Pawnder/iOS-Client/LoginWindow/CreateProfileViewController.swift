//
//  ProfileViewController.swift
//  LoginWindow
//
//  Created by Kory Brown on 7/26/15.
//  Copyright © 2015 Alpha. All rights reserved.
//

import UIKit
import Parse

class CreateProfileViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    
    var currentUser : Profile?
    var profiles = [Profile]()
    
    // MARK: Properties
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userFirstName: UITextField!
    @IBOutlet weak var userLastName: UITextField!
    @IBOutlet weak var userPhoneNumber: UITextField!
    @IBOutlet weak var create: UIButton!
    @IBOutlet weak var save: UIBarButtonItem!
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        userEmail.delegate = self
        userFirstName.delegate = self
        userLastName.delegate = self
        userPhoneNumber.delegate = self
        
        let email = currentUser?.email ?? ""
        userEmail.text = email
        let firstName = currentUser?.firstName ?? ""
        userFirstName.text = firstName
        let lastName = currentUser?.lastName ?? ""
        userLastName.text = lastName
        let phoneNumber = currentUser?.phoneNumber ?? ""
        userPhoneNumber.text = phoneNumber
        let photo = currentUser?.photo ?? UIImage(named: "defaultPhoto")
        userImage.image = photo
        
        // if these arent empty disable create button - once photos is able to be added  take out ! on userImage
        if !userFirstName.text!.isEmpty || !userLastName.text!.isEmpty || !userPhoneNumber.text!.isEmpty || !userImage.image!.isEqual(UIImage(named: "defaultPhoto"))
        {
            create.hidden = true
        }
        else
        {
            create.hidden = false
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: Segue
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool
    {
        
        if userEmail.text!.isEmpty || userFirstName.text!.isEmpty || userLastName.text!.isEmpty || userPhoneNumber.text!.isEmpty || userImage == nil
        {
            print("Fields are empty... Please fill in!")
            return false
        }
        else {
            return true
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if save === sender
        {
            currentUser!.email = userEmail.text ?? ""
            currentUser!.firstName = userFirstName.text ?? ""
            currentUser!.lastName = userLastName.text ?? ""
            currentUser!.phoneNumber = userPhoneNumber.text ?? ""
            currentUser!.photo = userImage.image ?? userImage.image
        }
        else
        {
            let navi = segue.destinationViewController as! UINavigationController
            let secondScene = navi.viewControllers.first as! ProfileViewController
            
            secondScene.currentUser = currentUser!
        }
        
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        // Hide Keyboard
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController)
    {
        // Dismiss the picker if the user canceled
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        // The info dictionary contains multiple representations of the image, and this uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        userImage.image = selectedImage
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    // MARK: Action
    
    @IBAction func createProfile(sender: UIButton)
    {
        var password = currentUser!.password
        var email = currentUser!.email
        var finalEmail = email.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        // Run a spinner to show a task in progress
        var spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
        spinner.startAnimating()
        
        var newUser = PFUser()
        newUser.username = email
        newUser.password = password
        newUser.email = finalEmail
        
        // Sign up the user asynchronously
        newUser.signUpInBackgroundWithBlock(
        { (succeed, error) -> Void in
            
            // Stop the spinner
            spinner.stopAnimating()
            if ((error) != nil)
            {
                var alert = UIAlertView(title: "Error", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                alert.show()
            }
            else
            {
                var alert = UIAlertView(title: "Success", message: "Signed Up", delegate: self, cancelButtonTitle: "OK")
                alert.show()
                //                saveProfile()
            }
        }
        )
        
        
        currentUser!.email = userEmail.text ?? ""
        currentUser!.firstName = userFirstName.text ?? ""
        currentUser!.lastName = userLastName.text ?? ""
        currentUser!.phoneNumber = userPhoneNumber.text ?? ""
        currentUser!.photo = userImage.image ?? userImage.image
        saveProfile()
    }
    
    @IBAction func cancel(sender: UIBarButtonItem)
    {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode
        {
            dismissViewControllerAnimated(true, completion: nil)
        }
        else
        {
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
    @IBAction func selectImageFromPhotoLibary(sender: UITapGestureRecognizer)
    {
        // Hide the keyboard
        userEmail.resignFirstResponder()
        userFirstName.resignFirstResponder()
        userLastName.resignFirstResponder()
        userPhoneNumber.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken
        imagePickerController.sourceType = .PhotoLibrary
        
        // Make sure ViewController is notified when the user picks image
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)
        
        
    }
    
    // MARK: Save
    func saveProfile()
    {
        let possibleUser = currentUser ?? nil
        
        if possibleUser!.isEqual(nil)
        {
            print("no user")
        }
        else
        {
            
            // save to database
            let profileObject = PFObject(className:"Users")
            profileObject["email"] = possibleUser?.email
            profileObject["password"] = possibleUser?.password
            profileObject["firstName"] = possibleUser?.firstName
            profileObject["lastName"] = possibleUser?.lastName
            profileObject["phoneNumber"] = possibleUser?.phoneNumber
            profileObject.saveInBackgroundWithBlock
            { (success: Bool, error: NSError?) -> Void in
                print("Object has been saved.")
            }
        }
    }
}
