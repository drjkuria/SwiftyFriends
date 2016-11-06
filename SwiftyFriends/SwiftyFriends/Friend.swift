//
//  Friend.swift
//  SwiftyFriends
//
//  Created by Jonah Kuria on 2016/11/07.
//  Copyright © 2016 Jonah Kuria. All rights reserved.
//

import Foundation
import SwiftyJSON

class Friend: NSObject{
    var imageURL: String?
    var alias: String?
    var lastSeen: String?
    var dateOfBirth: String?
    var firstName: String?
    var lastName: String?
    var status: String?
    
    init(data: Dictionary<String,String>) {
        super.init()
        for (key,value) in data {
            if data[key] != nil {
                self.setValue(value, forKey: key)
            }
        }
    }
    
}
