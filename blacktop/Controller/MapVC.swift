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
import Firebase

class MapVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    let authorizationStatus = CLLocationManager.authorizationStatus()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self
        
        confirmAuthStatus()
        
        cafePins()
    }

    @IBAction func profileBtnPressed(_ sender: Any) {
        DataService.instance.REF_CAFES.child((Auth.auth().currentUser?.uid)!).observeSingleEvent(of: .value) { (Snapshot) in
            if Snapshot.exists() {
                let cafePage = self.storyboard?.instantiateViewController(withIdentifier: "cafeProfileVC") as? CafeProfileVC
                self.present(cafePage!, animated: true, completion: nil)
            } else {
                let userPage = self.storyboard?.instantiateViewController(withIdentifier: "userProfileVC") as? UserProfileVC
                self.present(userPage!, animated: true, completion: nil)
            }
        }
    }
    
    func cafePins() {
        DataService.instance.REF_CAFES.observe(.value) { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else { return }
            for data in snapshot {
                let address = data.childSnapshot(forPath: "address").value as? String
//                print("\(address)")
                let geoCoder = CLGeocoder()
                geoCoder.geocodeAddressString(address!, completionHandler: { (place, error) in
                    let location = place?.first?.location
                    
                    let annotation = MKPointAnnotation()
                    var pinDrop = [location]
                    for location in pinDrop {
                    annotation.coordinate = (location?.coordinate)!
                    self.mapView.addAnnotation(annotation)
//                    print("\(location)")
                    }
                })
            }
        }
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
