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
        let textViewBackgroundColor = UIColor(white: 1, alpha: 0.3)
        
        self.view.addSubview(imageView)
        self.view.sendSubview(toBack: imageView)

        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        imageView.image = bgImage
        
        postName?.backgroundColor = textViewBackgroundColor
        postLevel?.backgroundColor = textViewBackgroundColor
        postSportType?.backgroundColor = textViewBackgroundColor
        postPhoneNumber?.backgroundColor = textViewBackgroundColor
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "PostTeamToAddUser"
        {
            if let dest = segue.destination as? AddUserViewController
            {
                print("sender: ", sender)
                if let sndr = sender as? UIButton
                {
                    dest.name = postName?.text
                    dest.level = postLevel?.text
                    dest.sportType = postSportType?.text
                    dest.phoneNumber = postPhoneNumber?.text
                    dest.date = (postDate?.date)!
                    
                    print("Segue:  ", dest.name)
                }
            }
        }
    }
}
