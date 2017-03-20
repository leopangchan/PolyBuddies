//
//  TeamDetailViewController.swift
//  Polybuddies
//
//  Created by CheckoutUser on 3/19/17.
//  Copyright © 2017 Yiupang Chan. All rights reserved.
//

import UIKit
import Firebase

class PersonTableCell: UITableViewCell
{
    @IBOutlet weak var emailView: UITextView!
    @IBOutlet weak var nameView: UITextView!
    @IBOutlet weak var sportTypeView: UITextView!
    @IBOutlet weak var phoneNumberView: UITextView!
    @IBOutlet weak var skillLevelView: UITextView!
    
    func initCells()
    {
        emailView.isEditable = false
        nameView.isEditable = false
        sportTypeView.isEditable = false
        phoneNumberView.isEditable = false
        skillLevelView.isEditable = false
    }
}

class TeamDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    public var team: Team?
    public var ppl: [User] = [] {
        didSet{
            self.teammemberTableView.reloadData()
        }
    }
    private var ref: FIRDatabaseReference?
    private var wrap: Wrappers?
    
    @IBOutlet weak var teammemberTableView: UITableView!
    @IBOutlet weak var skillLevelView: UITextView!
    @IBOutlet weak var phoneNumberView: UITextView!
    @IBOutlet weak var nameView: UITextView!
    @IBOutlet weak var sportTypeView: UITextView!
    @IBOutlet weak var addAPerson: UIButton!
    
    // initialize the array of Users in order display the teammembers of the team in question on the table
    override func viewWillAppear(_ animated: Bool)
    {
        var valueS: NSDictionary?

        self.ppl = []
        if team?.teammembers.count != 0
        {
            for (_, value) in (team?.teammembers.enumerated())!
            {
                ref?.child("Users").child(value).observe(.value, with: { (snapshot) in
                    valueS = snapshot.value as? NSDictionary
                    let oneUser = User(firstName: (self.wrap?.strWrapper(field: "First Name", valueS: valueS))!,
                                       lastName: (self.wrap?.strWrapper(field: "Last Name", valueS: valueS))!,
                                       phoneNumber: (self.wrap?.strWrapper(field: "Phone Number", valueS: valueS))!,
                                       sportType: (self.wrap?.strWrapper(field: "Sport Type", valueS: valueS))!,
                                       skillLevel: (self.wrap?.strWrapper(field: "Skill Level", valueS: valueS))!,
                                       email: (self.wrap?.strWrapper(field: "Email", valueS: valueS))!)
                    if (oneUser.firstName != "DB Error")
                    {
                        oneUser.prsID = value
                        self.ppl.append(oneUser)// check if the value from the loop would work here
                    }
                })
            }
        }
    }
    
    // Initialize the the style of text views in the UIViewController
    private func initTextView(team: Team)
    {
        let textViewBackgroundColor = UIColor(white: 1, alpha: 0.3)
        nameView.backgroundColor = textViewBackgroundColor
        skillLevelView.backgroundColor = textViewBackgroundColor
        phoneNumberView.backgroundColor = textViewBackgroundColor
        sportTypeView.backgroundColor = textViewBackgroundColor
        
        nameView?.text = team.name
        skillLevelView?.text = team.skillLevel
        phoneNumberView?.text = team.phoneNumber
        sportTypeView?.text = team.sportType
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let bgImage = UIImage(named: "SoccerFieldImage");
        let imageView = UIImageView(frame: self.view.bounds);
        
        imageView.image = bgImage
        self.view.addSubview(imageView)
        self.view.sendSubview(toBack: imageView)
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        ref = FIRDatabase.database().reference()

        if let team = team
        {
            self.initTextView(team: team)
            wrap = Wrappers()
            teammemberTableView.dataSource = self
            teammemberTableView.delegate = self
        }
        else
        {
            print ("Segue failed")
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return ppl.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell") as? PersonTableCell
        let onePerson = ppl[indexPath.row]
        
        cell?.initCells()
        cell?.nameView.text = onePerson.firstName + " " + onePerson.lastName
        cell?.emailView.text = onePerson.email
        cell?.sportTypeView.text = onePerson.sportType
        cell?.phoneNumberView.text = onePerson.phoneNumber
        cell?.skillLevelView.text = onePerson.skillLevel
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return CGFloat(170.0)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool)
    {
        super.setEditing(editing, animated: animated)
        teammemberTableView.setEditing(editing, animated: animated)
    }
    
    private func getPrsKey(teammembers : Any, deleting: String) -> String
    {
        print ("teammembers ", teammembers)
        for(index, val) in (teammembers as! [Any]).enumerated()
        {
            print ("val ", val)
            if(val as! String == deleting)
            {
                print ("KEY", val)
                return String(index)
            }
        }
        
        return "-1"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            let deletingID = ppl[indexPath.row].prsID
            let teammembers : Any
            
            ref?.child("Teams").child((team?.name)!).observe(.value, with: { (snapshot) in
                teammembers = snapshot["Teammember"]
            
            })
            
            let key = getPrsKey(teammembers: teammembers!, deleting: String(deletingID))
            
            ref?.child("Teams").child((team?.name)!).child("Teammember").child(key).removeValue()
            ppl.remove(at: indexPath.row)
            //teammemberTableView.deleteRows(at: [indexPath], with: .fade)
        }
        else if editingStyle == .insert
        {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "DetailToAddPerson"
        {
            if let dest = segue.destination as? AddUserViewController
            {
                if (sender as? UIButton) != nil
                {
                    dest.name = team?.name
                    dest.level = team?.skillLevel
                    dest.phoneNumber = team?.phoneNumber
                    dest.sportType = team?.sportType
                    dest.onlyStartTime = (team?.startTime)!
                    dest.onlyDate = (team?.date)!
                    dest.ppl = self.ppl
                    //print ("SEgue ppl ", self.ppl)
                    dest.beingAddedUser = (self.team?.teammembers)!
                }
            }
        }
    }
}
