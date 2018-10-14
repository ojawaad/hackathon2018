//
//  LoginViewController.swift
//  Hackathon2018
//
//  Created by John Christopher Briones on 10/14/18.
//  Copyright © 2018 Jc Briones. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    let defaultValues = UserDefaults.standard
    var user: User?
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogin(_ sender: Any) {
        loginUser(username: username.text!, password: password.text!)
    }
    
    private func loginUser(username: String, password: String) {
        // Loading
        let spinner = createSpinner()
        
        ConnectToAPI().userLogin(username: username, password: password) {
            (user, error) in
            
            // Stop loading
            self.destroySpinner(spinner)
            
            if let user = user {
                // Saving user values to defaults
                self.defaultValues.set(user.username, forKey: "username")
                
                // Successful login
//                print(user.username!)
                self.performSegue(withIdentifier: "unwindFromLogin", sender: self)
                self.user = user
            } else {
                self.alertUser("Login", msg: error)
            }
        }
        
    }
    
}
