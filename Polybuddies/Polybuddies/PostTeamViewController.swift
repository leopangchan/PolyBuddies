//
//  PostTeamViewController.swift
//  Polybuddies
//
//  Created by CheckoutUser on 2/21/17.
//  Copyright © 2017 Yiupang Chan. All rights reserved.
//

import UIKit


class PostTeamViewController: UIViewController, UIPickerViewDataSource,UIPickerViewDelegate
{
    
    private let alert = UIAlertController(title: "Yo!", message: "Please enter your all the fields.",
                                          preferredStyle: UIAlertControllerStyle.alert)
    // An array for PickerView for gyms or fields in Cal Poly
    private let locationArray = ["Rec Center", "Soccer Field", "Bagger Stadium", "Bob Janssen Field",
                                 "Dexter Lawn", "The P", "Other"]
    private var selectedLocation: String = "N/A"

    // UI Components
    @IBOutlet weak var postName: UITextField!
    @IBOutlet weak var postLevel: UITextField!
    @IBOutlet weak var postSportType: UITextField!
    @IBOutlet weak var postPhoneNumber: UITextField!
    @IBOutlet weak var postDate: UIDatePicker!
    @IBOutlet weak var locationPickerView: UIPickerView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sportTypeLabel: UILabel!
    @IBOutlet weak var phoneNoLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    
    private func initTextAndLabelView()
    {
        let textViewBackgroundColor = UIColor(white: 1, alpha: 0.3)
        let borderColor = UIColor.darkGray.cgColor;
        
        postName?.backgroundColor = textViewBackgroundColor
        postLevel?.backgroundColor = textViewBackgroundColor
        postSportType?.backgroundColor = textViewBackgroundColor
        postPhoneNumber?.backgroundColor = textViewBackgroundColor

        nameLabel.layer.borderColor = borderColor
        nameLabel.layer.borderWidth = 3.0
        nameLabel.layer.cornerRadius = 5.0
        nameLabel.textAlignment = NSTextAlignment.center
        
        sportTypeLabel.layer.borderColor = borderColor
        sportTypeLabel.layer.borderWidth = 3.0
        sportTypeLabel.layer.cornerRadius = 5.0
        sportTypeLabel.textAlignment = NSTextAlignment.center
        
        levelLabel.layer.borderColor = borderColor
        levelLabel.layer.borderWidth = 3.0
        levelLabel.layer.cornerRadius = 5.0
        levelLabel.textAlignment = NSTextAlignment.center
        
        phoneNoLabel.layer.borderColor = borderColor
        phoneNoLabel.layer.borderWidth = 3.0
        phoneNoLabel.layer.cornerRadius = 5.0
        phoneNoLabel.textAlignment = NSTextAlignment.center
    }
    
    @IBAction func post(_ sender: Any)
    {
        let checkFields = postName!.text! == "" || postLevel!.text! == "" ||
                          postSportType!.text! == "" || postPhoneNumber!.text! == ""
        if (!checkFields)
        {
            performSegue(withIdentifier: "PostTeamToAddUser", sender: sender)
        }
        else
        {
            self.present(alert, animated: true, completion: nil)
        }
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        let bgImage = UIImage(named: "SoccerFieldImage");
        let imageView = UIImageView(frame: self.view.bounds);

        self.view.addSubview(imageView)
        self.view.sendSubview(toBack: imageView)
        self.initTextAndLabelView()
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        imageView.image = bgImage
        
        locationPickerView.delegate = self
        locationPickerView.dataSource = self
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - PickerView
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return locationArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return locationArray.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
       selectedLocation = locationArray[row]
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "PostTeamToAddUser"
        {
            if let dest = segue.destination as? AddUserViewController
            {
                print("sender: ", sender!)
                if let _ = sender as? UIButton
                {
                    dest.name = postName?.text
                    dest.level = postLevel?.text
                    dest.sportType = postSportType?.text
                    dest.phoneNumber = postPhoneNumber?.text
                    dest.date = (postDate?.date)!
                    dest.location = selectedLocation
                    print("Segue:  ", dest.name!)
                }
            }
        }
    }
}
