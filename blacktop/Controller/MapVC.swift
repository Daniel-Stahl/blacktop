//
//  MapVC.swift
//  blacktop
//
//  Created by Daniel Stahl on 3/9/18.
//  Copyright © 2018 Daniel Stahl. All rights reserved.
//

import UIKit

class MapVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func profileBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toUserProfile", sender: nil)
    }


}
