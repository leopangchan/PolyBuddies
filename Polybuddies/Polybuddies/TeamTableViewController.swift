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

class TeamTableCell: UITableViewCell
{
    var team: Team?
}

class TeamTableViewController: UITableViewController
{
    private var ref: FIRDatabaseReference?
    private var teams: NSDictionary?
    private var allTeams: [Team] = []
    private var wrap: Wrappers?
    
    /*
     private func fetchMemmbersInATeam(userIds: NSArray) -> [User]
     {
     var users: [User] = []
     for index in 0 ..< userIds.count
     {
     ref?.child("Users").child(String(describing: userIds[index])).observe(.childAdded, with: { (snapshot) in
     if snapshot != nil
     {
     let valueS = snapshot.value as? NSDictionary
     let oneUser = User(firstName: valueS?["First Name"] as! String,
     lastName: valueS?["Last Name"] as! String,
     phoneNumber: valueS?["Phone Number"] as! String,
     sportType: valueS?["Sport Type"] as! String,
     skillLevel: valueS?["Skill Level"] as! String)
     users.append(oneUser)// check if the value from the loop would work here
     }
     })
     }
     
     return users
     }
     */
    
    /*
     sketcher.sketch(image: imageToSketch, completion: {(animation: SketchAnimation) -> Void in
     // This is the callback.  It's a closure, passed as the argument to the sketch function's completion parameter
     
     // Ask the end-user if they'd like to view the completed animation now...
     // You as a develoepr have access to the completed animation through the animation parameter to this closure
     })
     */
    

    
    
    @objc private func wrapperCB ()
    {
        print ("teams:  ", allTeams)
        self.tableView.reloadData()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.tableView.estimatedRowHeight = 100.0;
          self.tableView.rowHeight = UITableViewAutomaticDimension;
        wrap = Wrappers()        
        ref = FIRDatabase.database().reference()
        
        ref?.child("Teams").observe(.childAdded, with: { (snapshot) in
            let valueS = snapshot.value as? NSDictionary
            self.allTeams.append(Team(name: self.wrap!.strWrapper(field: "Name", valueS: valueS),
                                      skillLevel: self.wrap!.strWrapper(field: "Skill Level", valueS: valueS),
                                      sportType: self.wrap!.strWrapper(field: "Sport Type", valueS: valueS),
                                      longtitude: self.wrap!.doubleWrapper(field: "longtitude", valueS: valueS),
                                      latitude: self.wrap!.doubleWrapper(field: "latitude", valueS: valueS),
                                      teammembers: self.wrap!.teamWrapper(ref: self.ref!, valueS: valueS),
                                      availabilities: [Availibility(date: self.wrap!.strWrapper(field: "AvailableDates", valueS: valueS),
                                                                    startTime: self.wrap!.strWrapper(field: "StartTime", valueS: valueS),
                                                                    endTime: self.wrap!.strWrapper(field: "EndTime", valueS: valueS))],
                                      phoneNumber: self.wrap!.strWrapper(field: "Phone Number", valueS: valueS)))
            print("allTemas", self.allTeams)
        })
        
        DispatchQueue.main.asyncAfter(
            deadline: .now() + 2,
            execute: {self.wrapperCB()})
        
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
        return allTeams.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamCell", for: indexPath) as! TeamTableCell
        
        let oneTeam = self.allTeams[indexPath.row]
        cell.textLabel?.text = oneTeam.name
        cell.detailTextLabel?.text = "Sport Type: " + oneTeam.sportType + "     Level: " + oneTeam.skillLevel + "       Phone Number: " + oneTeam.phoneNumber
        cell.team = oneTeam

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
