//
//  CafeProfileSetupVC.swift
//  blacktop
//
//  Created by Daniel Stahl on 3/9/18.
//  Copyright © 2018 Daniel Stahl. All rights reserved.
//

import UIKit
import Firebase

class CafeProfileSetupVC: UIViewController {

    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var cafeName: UITextField!
    @IBOutlet weak var cafeDescription: UITextView!
    @IBOutlet weak var cafeAddress: UITextView!
    @IBOutlet weak var cafeHours: UITextView!
    @IBOutlet weak var website: UITextField!
    @IBOutlet weak var facebook: UITextField!
    @IBOutlet weak var twitter: UITextField!
    @IBOutlet weak var instagram: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveBtn.bindToKeyboard()
        
    }

    @IBAction func saveBtnPressed(_ sender: Any) {
        DataService.instance.cafeProfile(uid: (Auth.auth().currentUser?.uid)! ,name: cafeName.text!, description: cafeDescription.text!, address: cafeAddress.text!, hours: cafeHours.text!, website: website.text!, facebook: facebook.text!, twitter: twitter.text!, instagram: instagram.text!) { (success) in
            if success {
                print("details added to database")
            } else {
                print("could not save")
            }
        }
    }
    
}
