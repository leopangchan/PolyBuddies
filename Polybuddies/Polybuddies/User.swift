//
//  User.swift
//  Polybuddies
//
//  Created by CheckoutUser on 3/6/17.
//  Copyright © 2017 Yiupang Chan. All rights reserved.
//

import Foundation

class User
{
    private var _firstName: String = ""
    private var _lastName: String = ""
    private var _phoneNumber: String?
    private var _email: String = ""
    private var _sportType: String?
    private var _skillLevel: String?
    
    init(firstName: String, lastName: String, phoneNumber: String, sportType: String, skillLevel: String)
    {
        _firstName = firstName
        _lastName = lastName
        _phoneNumber = phoneNumber
        _sportType = sportType
        _skillLevel = skillLevel
    }
}
