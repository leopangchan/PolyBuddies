//
//  MapViewController.swift
//  Polybuddies
//
//  Created by CheckoutUser on 2/22/17.
//  Copyright © 2017 Yiupang Chan. All rights reserved.
//

import UIKit
import MapKit
import Firebase

private class PinAnnotation: NSObject, MKAnnotation
{
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D)
    {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}

class MapViewController: UIViewController
{
    @IBOutlet weak var map: MKMapView!
    private let SLO = CLLocationCoordinate2DMake(35.3050053, -120.66249419999997)
    private var ref: FIRDatabaseReference?
    private var allTeams: [smallTeam] = []
    
    // Since not all properties of a team are displayed in a pin, I created a struct to store all necessary data.
    private struct smallTeam
    {
        let name: String
        let sportType: String
        let date: String
        let startTime: String
        let location: String
    }

    private var wrap: Wrappers?
    
    override func viewWillAppear(_ animated: Bool)
    {
        ref?.child("Teams").observe(.childAdded, with: { (snapshot) in
            let valueS = snapshot.value as? NSDictionary
            self.allTeams.append(smallTeam(name: self.wrap!.strWrapper(field: "Name", valueS: valueS),
                                           sportType: self.wrap!.strWrapper(field: "Sport Type", valueS: valueS),
                                           date: self.wrap!.strWrapper(field: "AvailableDates", valueS: valueS),
                                           startTime: self.wrap!.strWrapper(field: "StartTime", valueS: valueS),
                                           location: self.wrap!.strWrapper(field: "Location", valueS: valueS)))})
    }
    
    // Get the latitude and longtitude of a location
    private func getLocationCoordinate(locationString: String) -> CLLocationCoordinate2D
    {
        if(locationString == "Rec Center")
        {
            return CLLocationCoordinate2DMake(35.29849859999999, -120.6599076)
        }
        else if (locationString == "Soccer Field")
        {
            return CLLocationCoordinate2DMake(35.31062521662127, -120.67212224006653)
        }
        else if (locationString == "Bagger Stadium")
        {
            return CLLocationCoordinate2DMake(35.3069122, -120.6651058)
        }
        else if (locationString == "Bob Janssen Field")
        {
            return CLLocationCoordinate2DMake(35.3071321, -120.6665435)
        }
        else if (locationString == "Dexter Lawn")
        {
            return CLLocationCoordinate2DMake(35.300591, -120.663121)
        }
        else if (locationString == "The P")
        {
            return CLLocationCoordinate2DMake(35.3028183, -120.651662)
        }
        else
        {
            return CLLocationCoordinate2DMake(35.3050053, -120.66249419999997)
        }
    }
    
    // TODO: Detect overlapping pins
    private func putPins()
    {
        for (_, value) in allTeams.enumerated()
        {
            var subtitle: String = "TBA"
            if (value.location != "Other" && value.location != "N/A")
            {
                subtitle = value.sportType + "    Date: " + value.date + "    Start Time: " + value.startTime
                let pinOne = PinAnnotation(title: value.name , subtitle: subtitle,
                                           coordinate: getLocationCoordinate(locationString: value.location))
                map.addAnnotation(pinOne)
            }
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let deadlineTime = DispatchTime.now() + .seconds(2)
        
        map.setRegion(MKCoordinateRegionMakeWithDistance(SLO, 1500, 1500), animated: true)
        wrap = Wrappers()
        ref = FIRDatabase.database().reference()

        DispatchQueue.main.asyncAfter(deadline: deadlineTime)
        {
            self.putPins();
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
