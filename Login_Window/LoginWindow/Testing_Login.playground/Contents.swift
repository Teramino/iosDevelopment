//: Playground - noun: a place where people can play

import UIKit

var password = "kbrown123"
var temp = [Character]()
password.characters.count




for char in password.characters {
    temp.append(char)
}


for var i=0; i<password.characters.count; i++ {
    temp[i] = password[(password.startIndex)]
}


struct Profile {
    
    var email: String
    var firstName: String?
    var lastName: String?
    var password: String
    var phoneNumber: Int?
    var photo: UIImage?
}

var newUser = Profile(email: "das", firstName: nil, lastName: nil, password: "1234", phoneNumber: nil, photo: nil)

