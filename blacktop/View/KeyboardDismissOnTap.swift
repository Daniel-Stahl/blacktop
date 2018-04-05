//
//  KeyboardDismissOnTap.swift
//  blacktop
//
//  Created by Daniel Stahl on 4/5/18.
//  Copyright © 2018 Daniel Stahl. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,action: #selector(dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}
