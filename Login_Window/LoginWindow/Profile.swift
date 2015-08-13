//
//  UserProfile.swift
//  LoginWindow
//
//  Created by Kory Brown on 7/26/15.
//  Copyright © 2015 Alpha. All rights reserved.
//

import UIKit


class Profile: NSObject, NSCoding {
    
    // MARK: Properties
    
    var email: String
    var password: String
    var firstName: String?
    var lastName: String?
    var phoneNumber: String?
    var photo: UIImage?
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("profile")
    
    // MARK: Types
    
    struct PropertyKey {
        static let emailKey = "email"
        static let passwordKey = "password"
        static let firstNameKey = "firstName"
        static let lastNameKey = "lastName"
        static let phoneNumberKey = "phoneNumber"
        static let photoKey = "photo"
    }
    
    init(email:String, password:String, firstName:String?, lastName:String?, phoneNumber:String?, photo:UIImage?) {
        self.email = email
        self.password = password
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.photo = photo
        
        super.init()
    }
    
    
    
    // MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(email, forKey: PropertyKey.emailKey)
        aCoder.encodeObject(password, forKey: PropertyKey.passwordKey)
        aCoder.encodeObject(firstName, forKey: PropertyKey.firstNameKey)
        aCoder.encodeObject(lastName, forKey: PropertyKey.lastNameKey)
        aCoder.encodeObject(phoneNumber, forKey: PropertyKey.phoneNumberKey)
        aCoder.encodeObject(photo, forKey: PropertyKey.photoKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let email = aDecoder.decodeObjectForKey(PropertyKey.emailKey) as! String
        let password = aDecoder.decodeObjectForKey(PropertyKey.passwordKey) as! String
        let firstName = aDecoder.decodeObjectForKey(PropertyKey.firstNameKey) as? String
        let lastName = aDecoder.decodeObjectForKey(PropertyKey.lastNameKey) as? String
        let phoneNumber = aDecoder.decodeObjectForKey(PropertyKey.phoneNumberKey) as? String
        let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as? UIImage
        
        self.init(email: email, password: password, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, photo: photo)
    }
    
}

