//
//  TeamTableViewController.swift
//  Polybuddies
//
//  Created by CheckoutUser on 2/22/17.
//  Copyright © 2017 Yiupang Chan. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON


class TeamTableViewController: UITableViewController
{
    
    private var ref:FIRDatabaseReference?
    private var teams: NSDictionary?
    private var allTeams: [Team]?
    
    private func fetchMemmbersInATeam(userIds: [Int]) -> [User]
    {
        var users: [User] = []
        for (index, value) in userIds {
            ref?.child("Users").observe(.childAdded, with: { (snapshot) in
                let valueS = snapshot
                users.append(valueS[value])// check if the value from the loop would work here
            })
        }
        return users
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        /*
         init(name: String, skillLevel: String, sportType: String, location: JSON,
         teammembers: [User], availabilities:[JSON], phoneNumber: String)
         */

        ref = FIRDatabase.database().reference()

        ref?.child("Teams").observe(.childAdded, with: { (snapshot) in
            
            let valueS = snapshot
            
            let oneTeam = Team(name: valueS["Name"], skillLevel: valueS["Skill Level"], sportType: valueS["Sport Type"],
                               location: ["longtitude": 123123.213, "latitude": 12312.55], teammembers: fetchMemmbersInATeam,
                               availabilities: {}, phoneNumber: valueS["Phone Number"])
            // 1. teammembers
            // 2. availabilities
            // 3. location
            print ("snapshot: ", valueS)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
