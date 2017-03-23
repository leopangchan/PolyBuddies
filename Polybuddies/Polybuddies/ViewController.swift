//
//  ViewController.swift
//  Polybuddies
//
//  Created by CheckoutUser on 2/21/17.
//  Copyright © 2017 Yiupang Chan. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var seeTeamsBtnOnMa: UIButton!
    @IBOutlet weak var showTeamButton: UIButton!
    @IBOutlet weak var postTeamBtn: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        showTeamButton.setImage(UIImage(named: "FindATeamHome.jpg"), for: .normal)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        let nav = self.navigationController?.navigationBar
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.yellow
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }
}

/*
 1. Post a team
 
 */

