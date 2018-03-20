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
    @IBOutlet weak var cafeName: UITextField!
    @IBOutlet weak var cafeDescription: UITextView!
    @IBOutlet weak var cafeAddress: UITextView!
    @IBOutlet weak var cafeHours: UITextView!
    @IBOutlet weak var website: UITextField!
    @IBOutlet weak var facebook: UITextField!
    @IBOutlet weak var twitter: UITextField!
    @IBOutlet weak var instagram: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    
    var takenBGImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bgImageTap()
        
    }
    
    func bgImageTap() {
        let tapImage = UITapGestureRecognizer(target: self, action: #selector(showActionSheet))
        tapImage.numberOfTapsRequired = 1
        bgImage.addGestureRecognizer(tapImage)
    }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        
        let cafeProfile = Cafe(image: takenBGImage, uid: (Auth.auth().currentUser?.uid)!, name: cafeName.text!, description: cafeDescription.text!, address: cafeAddress.text!, hours: cafeHours.text!, website: website.text!, facebook: facebook.text!, twitter: twitter.text!, instagram: instagram.text!)
        cafeProfile.save()
        
        
        
//        DataService.instance.cafeProfile(uid: (Auth.auth().currentUser?.uid)!,name: cafeName.text!, description: cafeDescription.text!, address: cafeAddress.text!, hours: cafeHours.text!, website: website.text!, facebook: facebook.text!, twitter: twitter.text!, instagram: instagram.text!) { (success) in
//            if success {
//                print("details added to database")
//            } else {
//                print("could not save")
//            }
//        }
    }
    
    func camera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraController = UIImagePickerController()
            cameraController.delegate = self
            cameraController.sourceType = .camera
            self.present(cameraController, animated: true, completion: nil)
        }
    }
    
    func photoLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryController = UIImagePickerController()
            photoLibraryController.delegate = self
            photoLibraryController.sourceType = .photoLibrary
            self.present(photoLibraryController, animated: true, completion: nil)
        }
    }
    
    @objc func showActionSheet() {
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.camera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.photoLibrary()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    
}

extension CafeProfileSetupVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let imageBG = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.takenBGImage = imageBG
        self.bgImage.image = takenBGImage
        self.dismiss(animated: true, completion: nil)
    }
    
}








