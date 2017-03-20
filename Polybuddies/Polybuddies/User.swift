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
    
    public var firstName: String {
        get{
            return _firstName
        }
        set{
            _firstName = newValue
        }
    }
    
    private var _lastName: String = ""
    public var lastName: String {
        get{
            return _lastName
        }
        set{
            _lastName = newValue
        }
    }
    
    private var _phoneNumber: String?
    public var phoneNumber: String {
        get{
            return _phoneNumber!
        }
        set{
            _phoneNumber = newValue
        }
    }
    
    private var _email: String?
    public var email: String {
        get{
            return _email!
        }
        set{
            _email = newValue
        }
    }
    
    private var _sportType: String?
    public var sportType: String {
        get{
            return _sportType!
        }
        set{
            _sportType = newValue
        }
    }
    
    private var _skillLevel: String?
    public var skillLevel: String {
        get{
            return _skillLevel!
        }
        set{
            _skillLevel = newValue
        }
    }
    
    private var _prsID: String?
    public var prsID: String{
        get{
            if let _prsID = _prsID
            {
                return _prsID
            }
            else
            {
                return "No teammembers"  
            }

        }
        set{
            _prsID = newValue
        }
    
    }
    
    init(firstName: String, lastName: String, phoneNumber: String, sportType: String, skillLevel: String, email: String)
    {
        _firstName = firstName
        _lastName = lastName
        _phoneNumber = phoneNumber
        _sportType = sportType
        _skillLevel = skillLevel
        _sportType = sportType
        _email = email
    }
}
