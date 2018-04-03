//
//  CafeProfile.swift
//  blacktop
//
//  Created by Daniel Stahl on 3/20/18.
//  Copyright © 2018 Daniel Stahl. All rights reserved.
//

import UIKit
import Firebase

class CafeProfileVC: UIViewController {

    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var cafeName: UILabel!
    @IBOutlet weak var cafeAddress: UILabel!
    @IBOutlet weak var cafeDescription: UILabel!
    @IBOutlet weak var cafeWebsite: UILabel!
    @IBOutlet weak var cafeFB: UILabel!
    @IBOutlet weak var cafeIG: UILabel!
    @IBOutlet weak var cafeTW: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getCafeProfile()
    }
    
    func getCafeProfile() {
        DataService.instance.REF_CAFES.child((Auth.auth().currentUser?.uid)!).observeSingleEvent(of: .value) { (Snapshot) in
            if let data = Snapshot.value as? [String: Any] {
                self.cafeName.text = data["name"] as? String
                self.cafeAddress.text = data["address"] as? String
                self.cafeDescription.text = data["description"] as? String
                self.cafeWebsite.text = data["website"] as? String
                self.cafeFB.text = data["facebook"] as? String
                self.cafeIG.text = data["instagram"] as? String
                self.cafeTW.text = data["tewitter"] as? String
            }
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        let toMap = storyboard?.instantiateViewController(withIdentifier: "mapVC") as! MapVC
        present(toMap, animated: true, completion: nil)
    }
    

}
