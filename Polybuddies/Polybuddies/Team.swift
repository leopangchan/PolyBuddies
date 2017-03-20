//
//  Team.swift
//  Polybuddies
//
//  Created by CheckoutUser on 2/23/17.
//  Copyright © 2017 Yiupang Chan. All rights reserved.
//

import Foundation
import SwiftyJSON

class Team
{
    private var _name: String?
    var name: String{
        get{
            return _name!
        }
        set{
            if newValue != name{
                _name = newValue
            }
        }
    }
    
    private var _skillLevel: String?
    var skillLevel: String{
        get{
            return _skillLevel!
        }
        set{
            if newValue != name{
                _skillLevel = newValue
            }
        }
    }
    
    private var _sportType: String?
    var sportType: String{
        get{
            return _sportType!
        }
        set{
            if newValue != name{
                _sportType = newValue
            }
        }
    }

    private var _location: JSON?// {latitude, longitude}
    var location: JSON{
        get{
            return _location!
        }
        set{
            if newValue != location{
                _location = newValue
            }
        }
    }
    
    private var _latitude: Double?
    var latitude: Double{
        get{
            return _latitude!
        }
        set{
            if newValue != _latitude{
                _latitude = newValue
            }
        }
    }
    
    private var _longtitude: Double?
    var longtitude: Double{
        get{
            return _longtitude!
        }
        set{
            if newValue != _longtitude{
                _longtitude = newValue
            }
        }
    }
    
    private var _teammembers: [String]?
    var teammembers: [String]{
        get{
            return _teammembers!
        }
        set{
            _teammembers = newValue
        }
    }

    private var _startTime: String?
    var startTime: String{
        get{
            return _startTime!
        }
        set{
            _startTime = newValue
        }
    }
    
    private var _date: String?
    var date: String{
        get{
            return _date!
        }
        set{
            _date = newValue
        }
    }
    
    private var _phoneNumber: String?
    var phoneNumber: String{
        get{
            return _phoneNumber!
        }
        set{
            _phoneNumber = newValue
        }
    }
    
    init(name: String, skillLevel: String, sportType: String, longtitude: Double, latitude: Double,
         teammembers: [String], date: String, startTime: String, phoneNumber: String)
    {
        _name = name
        _skillLevel = skillLevel
        _sportType = sportType
        _longtitude = longtitude
        _latitude = latitude
        _teammembers = teammembers
        _date = date
        _startTime = startTime
        _phoneNumber = phoneNumber
    }

}
