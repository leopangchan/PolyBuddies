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
    private let dateFormatter = DateFormatter()
    private var onlyDate : String = ""
    private var onlyStartTime : String = ""
    private let alert = UIAlertController(title: "Yo!", message: "Please enter your team's name.", preferredStyle: UIAlertControllerStyle.alert)
    
    @IBOutlet weak var postName: UITextField!
    @IBOutlet weak var postLevel: UITextField!
    @IBOutlet weak var postSportType: UITextField!
    @IBOutlet weak var postPhoneNumber: UITextField!
    @IBOutlet weak var postDate: UIDatePicker!
    @IBOutlet weak var teammemberView: UITextView!
    
    @IBAction func addAUser(_ sender: Any)
    {
        // pass the team's name
        // confirm the user has provided a team's name before segue
        let pn = postName.text!
        if pn != ""
        {
            performSegue(withIdentifier: "PostTeamToAddUser", sender: nil)
        }
        else
        {
            self.present(alert, animated: true, completion: nil)
        }

    }
    
    @IBAction func post(_ sender: Any) {
        if let ref = ref
        {
            let pn = postName.text!
            if pn != ""
            {
                ref.child(pn).child("Name").setValue(pn)
                ref.child(pn).child("Skill Level").setValue(postLevel.text!)
                ref.child(pn).child("Sport Type").setValue(postSportType.text!)
                ref.child(pn).child("Phone Number").setValue(postPhoneNumber.text!)
                let formattedDateArray = dateFormatter.string(from: postDate.date).components(separatedBy: " ")
                onlyDate = formattedDateArray[0]
                onlyStartTime = formattedDateArray[1]
                ref.child(pn).child("AvailableDates").setValue(onlyDate)
                ref.child(pn).child("StartTime").setValue(onlyStartTime)
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
        
        performSegue(withIdentifier: "ConfirmSegue", sender: nil)
    }

    private func getTeammembersNames() -> [String]
    {
        // Add a user page pass [User]
        // For the [User] to string
        return [""]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let bgImage = UIImage(named: "SoccerFieldImage");
        let imageView = UIImageView(frame: self.view.bounds);

        self.view.addSubview(imageView)
        self.view.sendSubview(toBack: imageView)
        self.dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss +ZZZZZ"
        
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        imageView.image = bgImage
        
        ref = FIRDatabase.database().reference(withPath: "Teams")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}
