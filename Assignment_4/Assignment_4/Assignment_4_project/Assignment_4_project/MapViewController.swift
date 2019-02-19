//
//  MapViewController.swift
//  Assignment_4_project
//
//  Created by Omid Azodi on 10/28/18.
//  Copyright © 2018 Omid Azodi. All rights reserved.
//

import UIKit
import MapKit   

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate
{
    
    @IBOutlet weak var Map_View: MKMapView!
    let distanceSpan: Double = 500
    
    override func viewDidLoad()
    
    {
        super.viewDidLoad()
        
        self.view.addSubview(self.Map_View!)
        
        // el cajon initially
        let initialLocation = CLLocation(latitude: 32.7948, longitude: -116.9625)
        // attempt to center to lat long hardcoded
        // the el cajon/reference lat long was received from google
        centerMapOnLocation(location: initialLocation)
       


        // Do any additional setup after loading the view.
    }
    // 45,000 meters and can convert that to miles
    // which is approx. what was guessed from trial and error
    // to see both El Cajon, and Escondido on the map
    let radius_to_zoom: CLLocationDistance = 45000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion =
            MKCoordinateRegion(center: location.coordinate,
                               latitudinalMeters: radius_to_zoom,
                               longitudinalMeters: radius_to_zoom)
        Map_View.setRegion(coordinateRegion, animated: true)
    }
}
