//
//  User.swift
//  Data303
//
//  Created by carlos on 18/3/18.
//  Copyright © 2018 carlos. All rights reserved.
//

import Foundation

class User {

    var firtsName: String?
    var lastName: String?
    var city: String?

    struct UserResponseKeys {
        static let FirstName = "fname"
        static let LastName = "lname"
        static let City = "city"
    }

    init (dictionary: NSDictionary) {
        if let _firtsName = dictionary.value(forKey: UserResponseKeys.FirstName) as Any? {
            firtsName = _firtsName as? String
        } else {
            firtsName = "Unknnow name"
        }
        if let _lastName = dictionary.value(forKey: UserResponseKeys.LastName) as Any? {
            lastName = _lastName as? String
        } else {
            lastName = "Unknnow last name"
        }
        if let _city = dictionary.value(forKey: UserResponseKeys.City) as Any? {
            city = _city as? String
        } else {
            city = "Unknnow city"
        }
    }
}
