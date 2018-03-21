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
    }

    @IBAction func profileBtnPressed(_ sender: Any) {
//        performSegue(withIdentifier: "toUserProfile", sender: nil)
        
        DataService.instance.REF_CAFES.observeSingleEvent(of: .value) { (Snapshot) in
            guard let cafeDict = Snapshot.children.allObjects as? [DataSnapshot] else { return }
            for data in cafeDict {
                let account = data.childSnapshot(forPath: "account").value as! String
                
                if account == "business" {
                    let toCafeProfile = self.storyboard?.instantiateViewController(withIdentifier: "cafeProfile") as! CafeProfileVC
                    self.present(toCafeProfile, animated: true, completion: nil)
                } else if Auth.auth().currentUser == DataService.instance.REF_USERS.child("users") {
                    self.performSegue(withIdentifier: "toUserProfile", sender: nil)
                }
                
                
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
