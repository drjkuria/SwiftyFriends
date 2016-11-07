//
//  FriendViewController.swift
//  SwiftyFriends
//
//  Created by Jonah Kuria on 2016/11/07.
//  Copyright © 2016 Jonah Kuria. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FriendViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var uniqueID: String?
    var firstName: String?
    var jsonArray:NSMutableArray?
    var friends: Array<Friend> = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        self.tableView.delegate = self
        
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
                        DispatchQueue.main.async{
                            self.tableView.reloadData()
                        }
                    }
                }
                
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendTableViewCell
        
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
        
        cell.aliasLabel.text = self.friends[indexPath.row].alias!
        guard let seen = self.friends[indexPath.row].lastSeen else {
            cell.lastSeenLabel.text = "last seen: not known"
            return cell
        }
        cell.lastSeenLabel.text = "last seen: " + seen
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetails" {
            let destinationVC = segue.destination as! FriendDetailsViewController
            
            guard let cell = sender as? UITableViewCell,
                let indexPath = tableView.indexPath(for: cell) else {
                    return
            }
            destinationVC.fullName = self.friends[indexPath.row].firstName! +
                " " + self.friends[indexPath.row].lastName!
            destinationVC.alias = self.friends[indexPath.row].alias!
            destinationVC.dateOfBirth = self.friends[indexPath.row].dateOfBirth!
            destinationVC.status = self.friends[indexPath.row].status!
        }
    }
}
