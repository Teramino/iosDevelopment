//
//  UserProfile.swift
//  LoginWindow
//
//  Created by Kory Brown on 7/26/15.
//  Copyright © 2015 Alpha. All rights reserved.
//

import UIKit

class Profile: NSObject
{
    
    // MARK: Properties
    var email: String
    var password: String
    var firstName: String?
    var lastName: String?
    var phoneNumber: String?
    var photo: UIImage?
 
    init(email:String, password:String, firstName:String?, lastName:String?, phoneNumber:String?, photo:UIImage?)
    {
        self.email = email
        self.password = password
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.photo = photo
        super.init()
    }
    
    convenience override init()
    {
        self.init(email:"", password: "", firstName: "", lastName: "", phoneNumber: "", photo: nil)
    }
    
    func printUser()
    {
        print("\(self.email)\n\(self.password)\n\(self.firstName)\n\(self.lastName)\n\(self.phoneNumber)\n\(self.photo)")
    }
    
}

