//
//  Wrappers.swift
//  Polybuddies
//
//  Created by CheckoutUser on 3/13/17.
//  Copyright © 2017 Yiupang Chan. All rights reserved.
//

import Foundation
import Firebase

class Wrappers {
    
    public func strWrapper(field : String, valueS : NSDictionary?) -> String
    {
        var strR: String
        
        if let valueS = valueS
        {
            print("unwarpping ", valueS )
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
    

    private func fetchMemmbersInATeam(ref: FIRDatabaseReference, userIds: NSDictionary) -> [User]
    {
        var users: [User] = []
        
        ref.child("Users").observe(.childAdded, with: { (snapshot) in
            let valueS = snapshot.value as? NSDictionary
            let userId = valueS?["userId"] as! Int
            
            for (index, value) in userIds
            {
                if(userId == value as! Int)
                {
                    let oneUser = User(firstName: self.strWrapper(field: "First Name", valueS: valueS),
                                       lastName: self.strWrapper(field: "Last Name", valueS: valueS),
                                       phoneNumber: self.strWrapper(field: "Phone Number", valueS: valueS),
                                       sportType: self.strWrapper(field: "Sport Type", valueS: valueS),
                                       skillLevel: self.strWrapper(field: "Skill Level", valueS: valueS))
                    users.append(oneUser)// check if the value from the loop would work here
                    print ("appending: ", users)
                }
            }
        })
        
        return users
    }
    
    
    public func teamWrapper(ref: FIRDatabaseReference, valueS : NSDictionary?) -> [User]
    {
        var nsDR : [User]?
        
        if let valueS = valueS
        {
            if let val = valueS["Teammember"]
            {
                nsDR = self.fetchMemmbersInATeam(ref: ref, userIds: valueS["Teammember"] as! NSDictionary)
            }
            else
            {
                nsDR = [User(firstName: "N/A", lastName: "N/A", phoneNumber: "N/A", sportType: "N/A", skillLevel: "N/A")]
            }
        }
        else
        {
            nsDR = [User(firstName: "DB Error", lastName: "N/A", phoneNumber: "N/A", sportType: "N/A", skillLevel: "N/A")]
        }
        
        return nsDR!
    }
    
    
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
