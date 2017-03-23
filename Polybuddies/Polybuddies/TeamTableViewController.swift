//
//  TeamTableViewController.swift
//  Polybuddies
//
//  Created by Yiupang on 2/22/17.
//  Copyright © 2017 Yiupang Chan. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON

class TeamTableCell: UITableViewCell
{
    var team: Team?

    @IBOutlet weak var teamNameView: UITextView!
    @IBOutlet weak var phoneNumberView: UITextView!
    @IBOutlet weak var skillLevelView: UITextView!
    @IBOutlet weak var sportTypeView: UITextView!
    @IBOutlet weak var addPersonBtn: UIButton!
    
    public func initViewStyle()
    {
        let textViewBackgroundColor = UIColor(white: 1, alpha: 0.3)
        self.layer.backgroundColor = UIColor.clear.cgColor
        teamNameView?.backgroundColor = textViewBackgroundColor
        phoneNumberView?.backgroundColor = textViewBackgroundColor
        skillLevelView?.backgroundColor = textViewBackgroundColor
        sportTypeView?.backgroundColor = textViewBackgroundColor
        
        teamNameView?.layer.cornerRadius = 5
        phoneNumberView?.layer.cornerRadius = 5
        skillLevelView?.layer.cornerRadius = 5
        sportTypeView?.layer.cornerRadius = 5
        
        teamNameView?.isEditable = false
        phoneNumberView?.isEditable = false
        skillLevelView?.isEditable = false
        sportTypeView?.isEditable = false
    }

}

class TeamTableViewController: UITableViewController
{
    private var ref: FIRDatabaseReference?
    private var teams: NSDictionary?
    private var allTeams: [Team] = []
    {
        didSet
        {
            self.tableView.reloadData()
        }
    }
    private var wrap: Wrappers?
    
    override func viewWillAppear(_ animated: Bool)
    {
        wrap = Wrappers()
        self.allTeams = []
        
        ref?.child("Teams").observe(.childAdded, with: { (snapshot) in
            let valueS = snapshot.value as? NSDictionary
            self.allTeams.append(Team(name: self.wrap!.strWrapper(field: "Name", valueS: valueS),
                                      skillLevel: self.wrap!.strWrapper(field: "Skill Level", valueS: valueS),
                                      sportType: self.wrap!.strWrapper(field: "Sport Type", valueS: valueS),
                                      longtitude: self.wrap!.doubleWrapper(field: "longtitude", valueS: valueS),
                                      latitude: self.wrap!.doubleWrapper(field: "latitude", valueS: valueS),
                                      teammembers: self.wrap!.teamWrapper(valueS: valueS),
                                      date: self.wrap!.strWrapper(field: "AvailableDates", valueS: valueS),
                                      startTime: self.wrap!.strWrapper(field: "StartTime", valueS: valueS),
                                      phoneNumber: self.wrap!.strWrapper(field: "Phone Number", valueS: valueS),
                                      location: self.wrap!.strWrapper(field: "Location", valueS: valueS)))})
        
        self.tableView.reloadData();
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        let bgImage = UIImage(named: "SoccerFieldImage");
        
        self.tableView.estimatedRowHeight = 300
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        ref = FIRDatabase.database().reference()
        
        self.tableView.backgroundColor = UIColor(patternImage: bgImage!)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // #warning Incomplete implementation, return the number of rows
        return allTeams.count
    }
    
    @objc private func performSegueSelector()
    {
        performSegue(withIdentifier: "ListingToAddUser", sender: self)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamCell", for: indexPath) as! TeamTableCell
        let oneTeam = self.allTeams[indexPath.row]

        cell.contentView.layer.opacity = 1.8;
        cell.teamNameView?.text = oneTeam.name
        cell.skillLevelView?.text = oneTeam.sportType
        cell.phoneNumberView?.text = oneTeam.phoneNumber
        cell.sportTypeView?.text = oneTeam.sportType
        cell.skillLevelView?.text = oneTeam.skillLevel
        cell.initViewStyle();

        cell.team = oneTeam

        return cell
    }
    
    // Resize height to fit the customized cells
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return CGFloat(155.0)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "ToTeamDetail"
        {
            if let dest = segue.destination as? TeamDetailViewController
            {
                if let sndr = sender as? TeamTableCell
                {
                    dest.team = sndr.team
                }
            }
        }
    }
}
