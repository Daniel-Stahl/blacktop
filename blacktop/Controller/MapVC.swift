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
        DataService.instance.REF_CAFES.child((Auth.auth().currentUser?.uid)!).observeSingleEvent(of: .value) { (Snapshot) in
            //Check if current user uid is in Cafes
            if Snapshot.exists() {
                let cafePage = self.storyboard?.instantiateViewController(withIdentifier: "cafeProfileVC") as? CafeProfileVC
                self.present(cafePage!, animated: true, completion: nil)
            } else {
                let userPage = self.storyboard?.instantiateViewController(withIdentifier: "userProfileVC") as? UserProfileVC
                self.present(userPage!, animated: true, completion: nil)
            }
        }
    }

    @IBAction func signoutButtonPressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            let loginPage = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
            self.present(loginPage!, animated: true, completion: nil)
        } catch {
            print(error)
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
