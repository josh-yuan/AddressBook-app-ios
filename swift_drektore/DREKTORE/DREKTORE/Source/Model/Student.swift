//
//  Student.swift
//  DREKTORE
//
//  Created by Joshua on 3/5/17.
//  Copyright © 2017 Joshua. All rights reserved.
//

import Foundation
class Student {
    var firstName: String
    var lastName: String
    var phoneNumber: String
    var email: String
    var parentName: String?
    var grade: Int
    var city: String?
    var address: String?
    var zipCode: String?
    
    init() {
        firstName = ""
        lastName = ""
        phoneNumber = ""
        email = ""
        parentName = ""
        grade = 0
        city = ""
        zipCode = ""
    }
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
        phoneNumber = ""
        email = ""
        parentName = ""
        grade = 0
        city = ""
        zipCode = ""
    }
    
    deinit {
        
    }
}
