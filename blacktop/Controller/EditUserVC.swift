//
//  EditUserVC.swift
//  blacktop
//
//  Created by Daniel Stahl on 3/10/18.
//  Copyright © 2018 Daniel Stahl. All rights reserved.
//

import UIKit
import Firebase

class EditUserVC: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

 
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logoutBtnPressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            let loginPage = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
            self.present(loginPage!, animated: true, completion: nil)
        } catch {
            print(error)
        }
    }
    
}
