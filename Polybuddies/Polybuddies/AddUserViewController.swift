//
//  AddUserViewController.swift
//  Polybuddies
//
//  Created by CheckoutUser on 3/16/17.
//  Copyright © 2017 Yiupang Chan. All rights reserved.
//

import UIKit

class AddUserViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let bgImage = UIImage(named: "SoccerFieldImage");
        let imageView = UIImageView(frame: self.view.bounds);
        imageView.image = bgImage
        self.view.addSubview(imageView)
        self.view.sendSubview(toBack: imageView)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
