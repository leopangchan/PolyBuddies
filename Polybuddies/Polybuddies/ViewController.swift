//
//  ViewController.swift
//  Polybuddies
//
//  Created by CheckoutUser on 2/21/17.
//  Copyright © 2017 Yiupang Chan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var seeTeamsBtnOnMa: UIButton!
    @IBOutlet weak var showTeamButton: UIButton!
    @IBOutlet weak var postTeamBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        showTeamButton.setImage(UIImage(named: "FindATeamHome.jpg"), for: .normal)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

