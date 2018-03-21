//
//  AuthService.swift
//  blacktop
//
//  Created by Daniel Stahl on 3/8/18.
//  Copyright © 2018 Daniel Stahl. All rights reserved.
//

import Foundation
import Firebase

class AuthService {
    static let instance = AuthService()
    
    func registerUser(email: String, password: String, userCreationComplete: @escaping (_ status: Bool,_ error: Error?) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            guard let user = user else {
                userCreationComplete(false, error)
                return
            }
            
            let userData = ["provider": user.providerID, "email": user.email]
            DataService.instance.createDBUser(uid: user.uid, userData: userData)
            userCreationComplete(true, nil)
        }
    }
    
    func loginUser(email: String, password: String, loginComplete: @escaping (_ status: Bool,_ error: Error?) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                loginComplete(false, error)
                return
            }
            loginComplete(true, nil)
        }
    }
    
    func registerCafe(email: String, password: String, cafeCreationComplete: @escaping (_ status: Bool,_ error: Error?) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { (cafe, error) in
            guard let cafe = cafe else {
                cafeCreationComplete(false, error)
                return
            }
            
            let cafeData = ["provider": cafe.providerID, "email": cafe.email, "account": "business"]
            DataService.instance.createDBCafe(uid: cafe.uid, userData: cafeData)
            cafeCreationComplete(true, nil)
        }
    }

    
    
    
}
