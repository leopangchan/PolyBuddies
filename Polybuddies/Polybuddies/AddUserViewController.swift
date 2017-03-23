//
//  AddUserViewController.swift
//  Polybuddies
//
//  Created by CheckoutUser on 3/16/17.
//  Copyright © 2017 Yiupang Chan. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON

class PersonCell: UITableViewCell
{
    public var prsID: String?
    
    @IBOutlet weak var emailCell: UITextView!
    @IBOutlet weak var skillLevelCell: UITextView!
    @IBOutlet weak var sportTypeCell: UITextView!
    @IBOutlet weak var phoneNumberCell: UITextView!
    @IBOutlet weak var nameTextCell: UITextView!
    
    func initCells()
    {
        emailCell.isEditable = false
        skillLevelCell.isEditable = false
        sportTypeCell.isEditable = false
        phoneNumberCell.isEditable = false
        nameTextCell.isEditable = false
        
        emailCell.layer.cornerRadius = 5
        skillLevelCell.layer.cornerRadius = 5
        sportTypeCell.layer.cornerRadius = 5
        phoneNumberCell.layer.cornerRadius = 5
        nameTextCell.layer.cornerRadius = 5
    }
}

class AddUserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate
{
    private var ref: FIRDatabaseReference?
    private var userRef: FIRDatabaseReference?
    
    // All fields are initialized by Segue:
    public var name: String?
    public var level: String?
    public var sportType: String?
    public var phoneNumber: String?
    public var date: Date?
    public var onlyDate : String = ""
    public var onlyStartTime : String = ""
    public var beingAddedUser : [String] = []// The keys being added in Teams in DB
    public var location: String = ""
    
    private let dateFormatter = DateFormatter()

    // UI Components:
    @IBOutlet weak var pplTableView: UITableView!
    @IBOutlet weak var skillLevelField: UITextField!
    @IBOutlet weak var sportTypeField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var firstNameField: UITextField!
    
    // Set up Alerts for empty fields
    private var alert : UIAlertController = UIAlertController(title: "Yo!", message: "Please enter your first name and email.", preferredStyle: UIAlertControllerStyle.alert)
    private var dupAlert : UIAlertController = UIAlertController(title: "Yo!", message: "This person is already in the team", preferredStyle: UIAlertControllerStyle.alert)
    
    // They are initialized by the data from DB
    public var ppl : [User] = []// The ppl being displayed in the TableView
    public var aPerson : User?
        {
        didSet
        {
            if let aPerson = aPerson
            {
                ppl.append(aPerson)
            }
        }
    }
    
    @IBAction func postATeam(_ sender: Any)
    {
        if let ref = ref
        {
            let pn = name!
            if pn != ""
            {
                // if the date is not formatted in the previous viewController that triggered a segue, 
                //    formate the date here.
                if onlyDate == "" && onlyStartTime == ""
                {
                    let formattedDateArray = dateFormatter.string(from: date!).components(separatedBy: " ")
                    onlyDate = formattedDateArray[0]
                    onlyStartTime = formattedDateArray[1]
                }
                
                ref.child(pn).setValue(["Name": pn,
                                        "Skill Level": level!,
                                        "Sport Type": sportType!,
                                        "Phone Number": phoneNumber!,
                                        "AvailableDates": onlyDate,
                                        "StartTime": onlyStartTime,
                                        "Teammember": beingAddedUser,
                                        "Location": location])
                
                performSegue(withIdentifier: "AddUserToListing", sender: sender)
            }
            else
            {
                self.present(alert, animated: true, completion: nil)// not going to here
            }
        }
        else
        {
            print ("Error fetching data from DB")
        }
    }
    
    // Add a Person to the tableView
    @IBAction func addPsr(_ sender: Any)
    {
        if (firstNameField!.text != "" || emailField!.text != "")
        {
            
            if(hasDuplicate(users: ppl, inputFirstName: firstNameField.text!,
                            inputLastName: lastNameField.text!))
            {
                self.present(dupAlert, animated: true, completion: nil)
            }
            else
            {
                aPerson = User(firstName: firstNameField.text!, lastName: lastNameField.text!,
                               phoneNumber: phoneNumberField.text!, sportType: sportTypeField.text!,
                               skillLevel: skillLevelField.text!, email: emailField.text!)
                self.addPrsToDB(usr: aPerson!)
                emailField?.text = ""
                lastNameField?.text = ""
                firstNameField?.text = ""
                sportTypeField?.text = ""
                skillLevelField?.text = ""
                phoneNumberField?.text = ""
            }
            
            pplTableView.reloadData()
        }
        else
        {
            self.present(alert, animated: true, completion: nil)
        }

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        
        return true
    }
    
    // A helper that post a Person to Users in DB
    private func addPrsToDB(usr : User)
    {
        if let userRef = userRef
        {
            let key: String = userRef.childByAutoId().key
            userRef.child(key).setValue(["Email": usr.email,
                                         "First Name": usr.firstName,
                                         "Last Name": usr.lastName,
                                         "Skill Level": usr.skillLevel,
                                         "Sport Type": usr.sportType,])
            usr.prsID = key
            beingAddedUser.append(key)
        }
    }

    // Check if a person is already in a team
    private func hasDuplicate(users : [User], inputFirstName: String, inputLastName: String) -> Bool
    {
        for ( _, value) in users.enumerated()
        {
            if(value.firstName == inputFirstName && value.lastName == inputLastName)
            {
                return true
            }
        }
        
        return false
    }
    
    // initialize styles of all text fields
    private func initTextFields()
    {
        let textViewBackgroundColor = UIColor(white: 1, alpha: 0.3)
        
        skillLevelField?.backgroundColor = textViewBackgroundColor
        sportTypeField?.backgroundColor = textViewBackgroundColor
        emailField?.backgroundColor = textViewBackgroundColor
        phoneNumberField?.backgroundColor = textViewBackgroundColor
        lastNameField?.backgroundColor = textViewBackgroundColor
        firstNameField?.backgroundColor = textViewBackgroundColor
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        pplTableView.dataSource = self
        pplTableView.delegate = self
        
        let bgImage = UIImage(named: "SoccerFieldImage");
        let imageView = UIImageView(frame: self.view.bounds);
        imageView.image = bgImage
        self.view.addSubview(imageView)
        self.view.sendSubview(toBack: imageView)
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss +ZZZZZ"
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        skillLevelField.delegate = self
        self.initTextFields()
        ref = FIRDatabase.database().reference(withPath: "Teams")
        userRef = FIRDatabase.database().reference(withPath: "Users")
    }
    
    // Set the table editable
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        pplTableView.setEditing(editing, animated: animated)
    }
    
    // Detext the editing mode
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            // Delete the row from the data source
            userRef?.child(ppl[indexPath.row].prsID).removeValue();
            ppl.remove(at: (indexPath as NSIndexPath).row)
            pplTableView.deleteRows(at: [indexPath], with: .fade)
        }
        else if editingStyle == .insert
        {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.ppl.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell") as? PersonCell
        let onePerson = ppl[indexPath.row]
        
        cell?.initCells()
        cell?.nameTextCell!.text = onePerson.firstName + " " + onePerson.lastName
        cell?.emailCell!.text = onePerson.email
        cell?.prsID = onePerson.prsID
        cell?.phoneNumberCell!.text = onePerson.phoneNumber
        cell?.skillLevelCell!.text = onePerson.skillLevel
        cell?.sportTypeCell!.text = onePerson.sportType
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return CGFloat(140.0)
    }
}
