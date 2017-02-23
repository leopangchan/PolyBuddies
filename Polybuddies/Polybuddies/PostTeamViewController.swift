//
//  PostTeamViewController.swift
//  Polybuddies
//
//  Created by CheckoutUser on 2/21/17.
//  Copyright © 2017 Yiupang Chan. All rights reserved.
//

import UIKit
import Firebase

class PostTeamViewController: UIViewController {
    private var ref:FIRDatabaseReference?
    
    @IBOutlet weak var postName: UITextField!
    @IBOutlet weak var postLevel: UITextField!
    @IBOutlet weak var postSportType: UITextField!
    

    @IBAction func post(_ sender: Any) {
        let name = postName.text!
        if let ref = ref {
            ref.child(name).child("Name").setValue(postName.text!)
            ref.child(name).child("Skill Level").setValue(postLevel.text!)
            ref.child(name).child("Sport Tpye").setValue(postSportType.text!)
        }
        else
        {
            print ("Error fetching data from DB")
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        ref = FIRDatabase.database().reference(withPath: "Teams")
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
