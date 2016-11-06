//
//  LoginViewController.swift
//  SwiftyFriends
//
//  Created by Jonah Kuria on 2016/11/06.
//  Copyright © 2016 Jonah Kuria. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginActivityIndicator: UIActivityIndicatorView!
    
    var guid: String? = nil
    var firstName: String? = nil
    
    @IBAction func signIn(_ sender: AnyObject) {
        loginActivityIndicator.hidesWhenStopped = true
        loginActivityIndicator.isHidden = false
        loginActivityIndicator.startAnimating()
        
        let username = usernameTextField.text
        let password = passwordTextField.text
        
        login(username: username!, password: password!)
 
    }
    
    func login(username: String, password: String){
        let parameters = [
            "username": username,
            "password": password
        ]
        
        let loginEndpoint: String = "http://mobileexam.dstv.com/login"
        var isSuccessful: Bool = false
        
        
        Alamofire.request(loginEndpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                
                if let value = response.result.value {
                    let postResult = JSON(value)
                    //                    use the result part of the postResult
                    //                    if true, its a success, so segue to the friends page
                    //                    if false, its a failure, so present an alert
                    var params: [String: String] = [:]
                    isSuccessful = postResult["result"].rawValue as! Bool
                    for (key, object) in postResult {
                        params[key] = object.stringValue
                    }
                    self.guid = params["guid"]
                    self.firstName = params["firstName"]
                }
                
                if(isSuccessful) {
                    self.performSegue(withIdentifier: "LoginSegue", sender: self)
                } else {
                    self.loginActivityIndicator.stopAnimating()
                    self.displayError(message: "Invalid credentials")
                }
        }
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
    
    func displayError(message:String) {
        let myAlert = UIAlertController(title:"Error", message:message, preferredStyle: UIAlertControllerStyle.alert);
        let okAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.default, handler:nil);
        myAlert.addAction(okAction);
        self.present(myAlert, animated:true, completion:nil);
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LoginSegue" {
//            let nav = segue.destination as! UINavigationController
            let destinationVC = segue.destination as! FriendsTableViewController
            
            destinationVC.firstName = firstName
            destinationVC.uniqueID = guid
        }
    }
}
