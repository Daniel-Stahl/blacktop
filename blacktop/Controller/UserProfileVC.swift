//
//  UserProfileVC.swift
//  blacktop
//
//  Created by Daniel Stahl on 3/9/18.
//  Copyright © 2018 Daniel Stahl. All rights reserved.
//

import UIKit
import Firebase

class UserProfileVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func settingsBtnPressed(_ sender: Any) {
        let editUserProfileVC = storyboard?.instantiateViewController(withIdentifier: "EditUserVC") as? EditUserVC
        self.present(editUserProfileVC!, animated: true, completion: nil)
    }
    
}
