//
//  InviteViewController.swift
//  Hackathon2018
//
//  Created by John Christopher Briones on 10/14/18.
//  Copyright © 2018 Jc Briones. All rights reserved.
//

import UIKit

class InviteViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onInvite(_ sender: Any) {
        // Loading
        let spinner = createSpinner()
        
        ConnectToAPI().inviteUser(email: emailTextField.text!) {
            (error) in
            
            // Stop loading
            self.destroySpinner(spinner)
            
            self.alertUser("Login", msg: error)
        }
        
    }
    
    
}
