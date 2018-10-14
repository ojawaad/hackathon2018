//
//  User.swift
//  Hackathon2018
//
//  Created by John Christopher Briones on 10/14/18.
//  Copyright © 2018 Jc Briones. All rights reserved.
//

import UIKit

class User {
    
    //MARK: Properties
    
    var id: Int
    var username: String
    var firstName: String
    var lastName: String
    var email: String
    
    //MARK: Initialization
    
    init?(id: Int, username: String, firstName: String, lastName: String, email: String) {
        
        // Initialize stored properties.
        self.id = id
        self.username = username
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
    }
    
    func toString() -> String {
        return "[\(id)]: \(firstName) \(lastName) (\(username))"
    }
}
