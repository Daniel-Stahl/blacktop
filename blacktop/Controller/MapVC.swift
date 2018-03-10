//
//  MapVC.swift
//  blacktop
//
//  Created by Daniel Stahl on 3/9/18.
//  Copyright © 2018 Daniel Stahl. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    let authorizationStatus = CLLocationManager.authorizationStatus()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self
        
        confirmAuthStatus()
    }

    @IBAction func profileBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toUserProfile", sender: nil)
    }


}

extension MapVC: MKMapViewDelegate {
    
}

extension MapVC: CLLocationManagerDelegate {
    func confirmAuthStatus() {
        if authorizationStatus == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        } else {
            return
        }
    }
}
