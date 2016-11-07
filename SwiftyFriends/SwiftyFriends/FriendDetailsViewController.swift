//
//  FriendDetailsViewController.swift
//  SwiftyFriends
//
//  Created by Jonah Kuria on 2016/11/07.
//  Copyright © 2016 Jonah Kuria. All rights reserved.
//

import UIKit

class FriendDetailsViewController: UIViewController {

    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var aliasLabel: UILabel!
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    
    var fullName: String?
    var alias: String?
    var dateOfBirth: String?
    var status: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fullNameLabel.text = fullName
        aliasLabel.text = alias
        dateOfBirthLabel.text = dateOfBirth
        statusLabel.text = status
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //    animate the details
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {
            self.fullNameLabel.textColor = UIColor.red
            
            self.aliasLabel.text = "alias: " + self.alias!
            self.dateOfBirthLabel.text = "date of birth: " + self.dateOfBirth!
            self.statusLabel.text = "status: " + self.status!
            
            self.aliasLabel.textColor = UIColor.orange
            self.dateOfBirthLabel.textColor = UIColor.blue
            self.statusLabel.textColor = UIColor.magenta
            
            self.view.backgroundColor = UIColor.cyan
            
            
            }, completion: { finished in
                print("done!")
        })
    }
}
