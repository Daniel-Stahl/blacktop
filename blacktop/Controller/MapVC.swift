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

class MapVC: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var pullUpView: UIView!
    @IBOutlet weak var mapViewBottomConstraint: NSLayoutConstraint!
    
    let locationManager = CLLocationManager()
    let authorizationStatus = CLLocationManager.authorizationStatus()
    let regionRadius: Double = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self
        //centerMapOnUserLocation()
        confirmAuthStatus()
        
        //touchPin()
        cafePins()
    }
    
//    func touchPin() {
//        let touch = UITapGestureRecognizer(target: self, action: #selector(cafePins))
//        touch.delegate = self
//        mapView.addGestureRecognizer(touch)
//    }

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
    
    func annimateViewUp() {
        mapViewBottomConstraint.constant = 300
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func centerButtonPressed(_ sender: Any) {
        if authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse {
            centerMapOnUserLocation()
        }
    }
    
    func centerMapOnUserLocation() {
        guard let coordinate = locationManager.location?.coordinate else { return }
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(coordinate, regionRadius * 2, regionRadius * 2)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}

extension MapVC: MKMapViewDelegate {
    //If someone doesnt put an address catch it.
    func cafePins() {
        DataService.instance.REF_CAFES.observe(.value) { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else { return }
            for data in snapshot {
                let address = data.childSnapshot(forPath: "address").value as? String
                
                let geoCoder = CLGeocoder()
                
                geoCoder.geocodeAddressString(address!, completionHandler: { (place, error) in
                    let location = place?.first?.location
                    let annotation = MKPointAnnotation()
                    let annotaionView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
                    var pinDrop = [location]
                    for location in pinDrop {
                        annotation.coordinate = (location?.coordinate)!
                        annotation.title = "cafe"
                        self.mapView.addAnnotation(annotation)
                    }
                    self.mapView(self.mapView, didSelect: annotaionView)
                })
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let pinToZoom = view.annotation
        let span = MKCoordinateSpanMake(0.5, 0.5)
        let region = MKCoordinateRegion(center: (pinToZoom?.coordinate)!, span: span)
        self.mapView.setRegion(region, animated: true)
        annimateViewUp()
    }
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
