//
//  Wrappers.swift
//  Polybuddies
//
//  Created by CheckoutUser on 3/13/17.
//  Copyright © 2017 Yiupang Chan. All rights reserved.
//

import Foundation
import Firebase

class Wrappers
{
    // If a field in DB is nil, return N/A
    public func strWrapper(field : String, valueS : NSDictionary?) -> String
    {
        var strR: String
        
        if let valueS = valueS
        {
            if let val = valueS[field]
            {
                strR = val as! String
            }
            else
            {
                strR = "N/A"
            }
        }
        else
        {
            strR = "DB Error"
        }
        
        return strR
    }

    // If no teammembers in a team, return []
    public func teamWrapper(valueS : NSDictionary?) -> [String]
    {
        var nsDR : [String]?
        
        if let valueS = valueS
        {
            if let val = valueS["Teammember"]
            {
                // It will not work the data is missing one index
                if let val = val as? [String]
                {
                    nsDR = val
                }
                else
                {
                    if let val = val as? [Any]
                    {
                        var nsDRTemp : [String] = []
                        for value in val {
                            nsDRTemp.append(String(describing: value))
                        }
                        nsDR = nsDRTemp
                    }
                }
            }
            else
            {
                nsDR = []
            }
        }
        else
        {
            nsDR = []
        }
        
        return nsDR!
    }
    
    // Set up default double value if the data isn't present in the DB
    public func doubleWrapper(field : String, valueS : NSDictionary?) -> Double
    {
        var doubleR: Double
        
        if let valueS = valueS
        {
            if let val = valueS[field]
            {
                doubleR = val as! Double
            }
            else
            {
                doubleR = 0.0
            }
        }
        else
        {
            doubleR = -999999.9
        }
        
        return doubleR
    }
}
