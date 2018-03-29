//
//  Cafe.swift
//  blacktop
//
//  Created by Daniel Stahl on 3/19/18.
//  Copyright © 2018 Daniel Stahl. All rights reserved.
//

import UIKit
import Firebase

class Cafe {
    
    private var image: UIImage!
    var name: String!
    var imageDownloadURL: String?
    var description: String!
    var address: String!
    var hours: String!
    var website: String
    var facebook: String!
    var twitter: String!
    var instagram: String!
    
    init(image: UIImage, name: String, description: String, address: String, hours: String, website: String, facebook: String, twitter: String, instagram: String) {
        self.image = image
        self.name = name
        self.description = description
        self.address = address
        self.hours = hours
        self.website = website
        self.facebook = facebook
        self.twitter = twitter
        self.instagram = instagram
    }
    
    func save() {
//        let cafeRef = DataService.instance.REF_CAFES.child("cafes")
        let cafeID = Auth.auth().currentUser?.uid
        
        if let imageData = UIImageJPEGRepresentation(self.image, 0.6) {
            let imageRef = DataService.instance.REF_STORAGE.child(cafeID!)
            
            imageRef.putData(imageData).observe(.success, handler: { (imageSnapshot) in
                self.imageDownloadURL = imageSnapshot.metadata?.downloadURL()?.absoluteString
                
                let cafeDictionary = [
                    "imageDownloadURL" : self.imageDownloadURL,
                    "name" : self.name,
                    "description" : self.description,
                    "address" : self.address,
                    "hours" : self.hours,
                    "website" : self.website,
                    "facebook" : self.facebook,
                    "twitter" : self.twitter,
                    "instagram" : self.instagram
                    
                ]
                DataService.instance.REF_CAFES.child((Auth.auth().currentUser?.uid)!).updateChildValues(cafeDictionary)
            })
        }
    }
    
    
    
    
    
    
}
