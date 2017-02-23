//
//  MapViewController.swift
//  Polybuddies
//
//  Created by CheckoutUser on 2/22/17.
//  Copyright © 2017 Yiupang Chan. All rights reserved.
//

import UIKit
import MapKit

private class PinAnnotation: NSObject, MKAnnotation
{
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}

class MapViewController: UIViewController
{
    @IBOutlet weak var map: MKMapView!
    let SLO = CLLocationCoordinate2DMake(35.3050053, -120.66249419999997)
    let recCnter = CLLocationCoordinate2DMake(35.29849859999999, -120.6599076)
    let soccerField = CLLocationCoordinate2DMake(35.31062521662127, -120.67212224006653)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        map.setRegion(MKCoordinateRegionMakeWithDistance(SLO, 1500, 1500), animated: true)
        // pin will be updated dynamacally from user's phone
        let pinOne = PinAnnotation(title: "TeamOne", subtitle: "Look for a teammate", coordinate: recCnter)
        map.addAnnotation(pinOne)
        let pinTwo = PinAnnotation(title: "TeamTwo", subtitle: "Look for a teammate", coordinate: soccerField)
        map.addAnnotation(pinTwo)
    }

    override func didReceiveMemoryWarning()
    {
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
