//
//  ViewTeamViewController.swift
//  Polybuddies
//
//  Created by CheckoutUser on 2/21/17.
//  Copyright © 2017 Yiupang Chan. All rights reserved.
//

import UIKit
import SwiftyJSON
import Firebase

class ViewTeamViewController: UIViewController {

    private var ref:FIRDatabaseReference?
    /*private var _testTeamName: String = ""
    var testTeamName: String {
        get{
            return _testTeamName
        }
        set{
            if newValue != testTeamName{
                _testTeamName = FIRDatabase.database().reference(withPath: "TeamOne/Name") as! String
        }
    }*/

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = FIRDatabase.database().reference()
        // with is a callback
        // snapshot refers to the data from the DB
        // observe returns uid that references all the updates under TeamOne
        ref?.child("TeamOne").observe(.childAdded, with: { (snapshot) in
            // Code to execute when a child is added under "TemaOne"
            let valueS = snapshot.value as? String
            if let actualValueS = valueS{
                print (actualValueS)
            }

        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
