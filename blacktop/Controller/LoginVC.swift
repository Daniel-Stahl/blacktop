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
    @IBOutlet weak var chooseAccount: UISegmentedControl!
    
    var chosenAccount: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboard()
        
    }
    
    @IBAction func chooseAccountSelected(_ sender: Any) {
        switch chooseAccount.selectedSegmentIndex {
        case 0:
            chosenAccount = "user"
        case 1:
            chosenAccount = "cafe"
        default:
            break
        }
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
        if emailField.text != nil && passwordField.text != nil && chosenAccount == "user" {
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
        } else if emailField.text != nil && passwordField.text != nil && chosenAccount == "cafe" {
            AuthService.instance.registerCafe(email: emailField.text!, password: passwordField.text!, cafeCreationComplete: { (success, registerError) in
                if success {
                    AuthService.instance.loginUser(email: self.emailField.text!, password: self.passwordField.text!, loginComplete: { (success, nil) in
                        print("Cafe signed up!")
                        let cafeProfileSetup = self.storyboard?.instantiateViewController(withIdentifier: "cafeProfileSetup")
                        self.present(cafeProfileSetup!, animated: true, completion: nil)
                    })
                } else {
                    print(String(describing: registerError?.localizedDescription))
                }
            })
        }
    }
}
