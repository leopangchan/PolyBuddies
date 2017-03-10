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
    
    private var _teammembers: [User]?
    var teammembers: [User]{
        get{
            return _teammembers!
        }
        set{
            _teammembers = newValue
        }
    }
    
    private var _availabilities: [JSON]?// {startDate, endDate, startTime, endTime}
    var availabilities: [JSON]{
        get{
            return _availabilities!
        }
        set{
            _availabilities = newValue
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
    
    init(name: String, skillLevel: String, sportType: String, location: JSON,
        teammembers: [User], availabilities:[JSON], phoneNumber: String)
    {
        
        
    }

}
