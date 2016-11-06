//
//  LoginViewController.swift
//  SwiftyFriends
//
//  Created by Jonah Kuria on 2016/11/06.
//  Copyright © 2016 Jonah Kuria. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginActivityIndicator: UIActivityIndicatorView!
    
    @IBAction func signIn(_ sender: AnyObject) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        passwordTextField.isSecureTextEntry = true
        loginActivityIndicator.isHidden = true
        loginActivityIndicator.hidesWhenStopped = true
        loginButton.setTitle("Login", for: UIControlState.normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    

}
