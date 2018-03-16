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
    
    var imagePicker: UIImagePickerController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bgImageTap()
        avatarTap()
        
    }
    
    func bgImageTap() {
        let tapImage = UITapGestureRecognizer(target: self, action: #selector(selectImage(sender:)))
        tapImage.numberOfTapsRequired = 1
        bgImage.addGestureRecognizer(tapImage)
    }
    
    func avatarTap() {
        let tapImage = UITapGestureRecognizer(target: self, action: #selector(selectImage(sender:)))
        tapImage.numberOfTapsRequired = 1
        avatar.addGestureRecognizer(tapImage)
    }
    
    
    @objc func selectImage(sender: UITapGestureRecognizer) {
        imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            imagePicker.cameraCaptureMode = .photo
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        self.present(imagePicker, animated: true, completion: nil)
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
