//
//  PostTeamViewController.swift
//  Polybuddies
//
//  Created by CheckoutUser on 2/21/17.
//  Copyright © 2017 Yiupang Chan. All rights reserved.
//

import UIKit


class PostTeamViewController: UIViewController {
    
    private let alert = UIAlertController(title: "Yo!", message: "Please enter your all the fields.", preferredStyle: UIAlertControllerStyle.alert)

    @IBOutlet weak var postName: UITextField!
    @IBOutlet weak var postLevel: UITextField!
    @IBOutlet weak var postSportType: UITextField!
    @IBOutlet weak var postPhoneNumber: UITextField!
    @IBOutlet weak var postDate: UIDatePicker!
    
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
        nameLabel.layer.borderWidth = 1.0
        
        sportTypeLabel.layer.borderColor = borderColor
        sportTypeLabel.layer.borderWidth = 1.0
        
        levelLabel.layer.borderColor = borderColor
        levelLabel.layer.borderWidth = 1.0
        
        phoneNoLabel.layer.borderColor = borderColor
        phoneNoLabel.layer.borderWidth = 1.0
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

    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
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
                    
                    print("Segue:  ", dest.name!)
                }
            }
        }
    }
}
