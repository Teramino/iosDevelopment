//
//  ProfileViewController.swift
//  LoginWindow
//
//  Created by Kory Brown on 8/3/15.
//  Copyright © 2015 Alpha. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    
    // MARK: Properties
    var currentUser : Profile?
    
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userFirstName: UILabel!
    @IBOutlet weak var userLastName: UILabel!
    @IBOutlet weak var userPhoneNumber: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {        
        if segue.identifier == "ShowDetail" {
            let navi = segue.destinationViewController as! UINavigationController
            let detailProfileController = navi.viewControllers.first as! CreateProfileViewController
            detailProfileController.currentUser = currentUser
        }
            // added to pass current user to homescrren
        else if segue.identifier == "HomeScreen" {
            let homeController = segue.destinationViewController as! HomeScreen
            homeController.currentUser = currentUser
        }
    }
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? CreateProfileViewController{
            
            sourceViewController.saveProfile()
            
            currentUser = sourceViewController.currentUser
            
            userEmail.text = currentUser!.email
            userFirstName.text = currentUser!.firstName
            userLastName.text! != currentUser!.lastName
            userPhoneNumber.text = currentUser!.phoneNumber
            userImage.image = currentUser!.photo
        }
    }
    
    
}
