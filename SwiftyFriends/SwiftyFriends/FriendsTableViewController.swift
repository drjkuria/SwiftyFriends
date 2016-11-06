//
//  FriendsTableViewController.swift
//  SwiftyFriends
//
//  Created by Jonah Kuria on 2016/11/06.
//  Copyright © 2016 Jonah Kuria. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FriendsTableViewController: UITableViewController {
    
    var uniqueID: String?
    var firstName: String?
    var jsonArray:NSMutableArray?
    var friends: Array<Friend> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Friends"
        self.navigationItem.hidesBackButton = true
        
        let friendsEndpoint: String = "http://mobileexam.dstv.com/friends.php" +
        "?name=" + firstName! + ";uniqueID=" + uniqueID!
        
        
        Alamofire.request(friendsEndpoint, method: .post)
        .responseJSON { response in
            
            if let getResponse = response.result.value {
                let jsonResult = JSON(getResponse)
                var friendDict = [String: String]()
                if let items = jsonResult["friends"].array {
                    for item in items {
                        for (key, value) in item {
                            friendDict[key] = value.rawString()!
                        }
                        let friend = Friend(data: friendDict)
                        self.friends.append(friend)
                    }
                    self.tableView.reloadData()
                }
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.friends.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath)
        
        //        load image async
        let urlString = self.friends[indexPath.row].imageURL
        URLSession.shared.dataTask(with: NSURL(string: urlString!)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                if let cellToUpdate = tableView.cellForRow(at: indexPath) {
                    cellToUpdate.imageView?.image = image
                }
            })
            
        }).resume()
        
        cell.textLabel?.text = self.friends[indexPath.row].alias
        
        return cell
    }
}
