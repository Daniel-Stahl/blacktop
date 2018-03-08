//
//  ViewController.swift
//  blacktop
//
//  Created by Daniel Stahl on 3/8/18.
//  Copyright © 2018 Daniel Stahl. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.delegate = self
        passwordField.delegate = self
    }

    @IBAction func loginPressed(_ sender: Any) {
        if emailField.text != nil && passwordField.text != nil {
            AuthService.instance.loginUser(email: emailField.text!, password: passwordField.text!, loginComplete: { (success, loginError) in
                if success {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    print(String(describing: loginError?.localizedDescription))
                }
            })
        }
    }
    
    @IBAction func signupPressed(_ sender: Any) {
        if emailField.text != nil && passwordField.text != nil {
            AuthService.instance.registerUser(email: emailField.text!, password: passwordField.text!, userCreationComplete: { (success, registerError) in
                if success {
                    AuthService.instance.loginUser(email: self.emailField.text!, password: self.passwordField.text!, loginComplete: { (success, nil) in
                        print("Successfully signed up")
                        self.dismiss(animated: true, completion: nil)
                    })
                } else {
                    print(String(describing: registerError?.localizedDescription))
                }
            })
        }
    }
}

extension LoginVC: UITextFieldDelegate {
    
}
