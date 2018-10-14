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
        // Loading
        let spinner = createSpinner()
        
        ConnectToAPI().userLogin(username: username.text!, password: password.text!) {
            (user, error) in
            
            // Stop loading
            self.destroySpinner(spinner)
            
            if let user = user {
                // Saving user values to defaults
                self.defaultValues.set(user.username, forKey: "username")
                
                // Successful login
                //                print(user.username!)
                self.user = user
                self.performSegue(withIdentifier: "unwindFromLogin", sender: self)
            } else {
                self.alertUser("Login", msg: error)
            }
        }
        
    }
    
}
