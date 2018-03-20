//
//  DataService.swift
//  blacktop
//
//  Created by Daniel Stahl on 3/8/18.
//  Copyright © 2018 Daniel Stahl. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()
let DB_Storage = Storage.storage().reference()

class DataService {
    static let instance = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_CAFES = DB_BASE.child("cafes")
    private var _REF_ROASTERS = DB_BASE.child("roasters")
    
    private var _REF_STORAGE = DB_Storage.child("photos")
    
    var REF_STORAGE: StorageReference {
        return _REF_STORAGE
    }
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    var REF_CAFES: DatabaseReference {
        return _REF_CAFES
    }
    
    var REF_ROASTERS: DatabaseReference {
        return _REF_ROASTERS
    }
    
    func createDBUser(uid: String, userData: Dictionary<String, Any>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    func createDBCafe(uid: String, userData: Dictionary<String, Any>) {
        REF_CAFES.child(uid).updateChildValues(userData)
    }
    
    func cafeProfile(uid: String, name: String, description: String, address: String, hours: String, website: String, facebook: String, twitter: String, instagram: String, profileComplete: @escaping (_ success: Bool) -> ()) {
        REF_CAFES.child(uid).updateChildValues(["name": name, "description": description, "address": address, "hours": hours, "website": website, "facebook": facebook, "twitter": twitter, "instagram": instagram])
        profileComplete(true)
    }
    
    
    
    
    
    
}
