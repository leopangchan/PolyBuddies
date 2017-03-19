//
//  AddUserViewController.swift
//  Polybuddies
//
//  Created by CheckoutUser on 3/16/17.
//  Copyright © 2017 Yiupang Chan. All rights reserved.
//

import UIKit
import Firebase

class PersonCell: UITableViewCell
{
    
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
    }
}

class AddUserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    private var ref: FIRDatabaseReference?
    private var userRef: FIRDatabaseReference?
    public var name: String?
    public var level: String?
    public var sportType: String?
    public var phoneNumber: String?
    public var date: Date?
    private let dateFormatter = DateFormatter()
    private var onlyDate : String = ""
    private var onlyStartTime : String = ""
    private var beingAddedUser : [Int] = []

    @IBOutlet weak var pplTableView: UITableView!
    @IBOutlet weak var skillLevelField: UITextField!
    @IBOutlet weak var sportTypeField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var firstNameField: UITextField!
    private var alert : UIAlertController = UIAlertController(title: "Yo!", message: "Please enter your first name and email.", preferredStyle: UIAlertControllerStyle.alert)
    private var dupAlert : UIAlertController = UIAlertController(title: "Yo!", message: "This person is already in the team", preferredStyle: UIAlertControllerStyle.alert)
    
    private var ppl : [User] = []
    public var aPerson : User?
        {
        didSet
        {
            if let aPerson = aPerson
            {
                ppl.append(aPerson)
                print("appending: ", ppl)
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
                let formattedDateArray = dateFormatter.string(from: date!).components(separatedBy: " ")
                ref.child(pn).child("Name").setValue(pn)
                ref.child(pn).child("Skill Level").setValue(level!)
                ref.child(pn).child("Sport Type").setValue(sportType)
                ref.child(pn).child("Phone Number").setValue(phoneNumber)
                onlyDate = formattedDateArray[0]
                onlyStartTime = formattedDateArray[1]
                ref.child(pn).child("AvailableDates").setValue(onlyDate)
                ref.child(pn).child("StartTime").setValue(onlyStartTime)
                //ref.child(pn).child("Teammember").push({})
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

    @IBAction func didTouchDownFirstNameEditing(_ sender: Any)
    {
        firstNameField.layer.borderColor = UIColor.gray.cgColor
        firstNameField.layer.borderWidth = 1
        firstNameField.layer.cornerRadius = 5
    }
    
    @IBAction func didEndFirstNameEditing(_ sender: Any)
    {
        firstNameField.layer.borderWidth = 0
    }
    
    @IBAction func didTouchDownLastName(_ sender: Any)
    {
        firstNameField.layer.borderColor = UIColor.gray.cgColor
        firstNameField.layer.borderWidth = 1
        firstNameField.layer.cornerRadius = 5
    }
    
    @IBAction func didEndEditingLastName(_ sender: Any)
    {
        firstNameField.layer.borderWidth = 0
    }
    
    @IBAction func addPsr(_ sender: Any)
    {
        if (firstNameField!.text != "" || emailField!.text != "")
        {
            
            if(hasDuplicate(users: ppl, inputFirstName: firstNameField.text!, inputLastName: lastNameField.text!))
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
    
    private func addPrsToDB(usr : User)
    {
        if let userRef = userRef
        {
            userRef.setValue(usr)
        }
    }
    
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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let bgImage = UIImage(named: "SoccerFieldImage");
        let imageView = UIImageView(frame: self.view.bounds);
        let textViewBackgroundColor = UIColor(white: 1, alpha: 0.3)

        imageView.image = bgImage
        self.view.addSubview(imageView)
        self.view.sendSubview(toBack: imageView)
        self.dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss +ZZZZZ"
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        
        pplTableView.dataSource = self
        pplTableView.delegate = self
        
        skillLevelField?.backgroundColor = textViewBackgroundColor
        sportTypeField?.backgroundColor = textViewBackgroundColor
        emailField?.backgroundColor = textViewBackgroundColor
        phoneNumberField?.backgroundColor = textViewBackgroundColor
        lastNameField?.backgroundColor = textViewBackgroundColor
        firstNameField?.backgroundColor = textViewBackgroundColor
        // Do any additional setup after loading the view.
        ref = FIRDatabase.database().reference(withPath: "Teams")
        userRef = FIRDatabase.database().reference(withPath: "Users")
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return ppl.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell") as? PersonCell
        let onePerson = ppl[indexPath.row]
        
        cell?.initCells()
        cell?.contentView.layer.opacity = 1.8;
        cell?.nameTextCell!.text = onePerson.firstName + " " + onePerson.lastName
        cell?.emailCell!.text = onePerson.email
        cell?.phoneNumberCell!.text = onePerson.phoneNumber
        cell?.skillLevelCell!.text = onePerson.skillLevel
        cell?.sportTypeCell!.text = onePerson.sportType
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return CGFloat(140.0)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // segue to show table view
    }

}
