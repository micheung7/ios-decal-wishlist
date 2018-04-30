//
//  UserCopyVC.swift
//  PriceTracker
//
//  Created by Michelle Cheung on 4/4/18.
//  Copyright © 2018 MAE. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class UserCopyVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var followUnfollowButton: UIButton!
    
    var emailFromPeopleSearch: String = ""
    var username = ""
    var userEmail = ""
    var friendList: [String] = [] // List of user ids
    var itemList: [String] = [] // List of item ids
    var items: [Item] = []
    
    var itemNameToSend: String = ""
    var itemURLToSend: String = ""
    var itemSizeToSend: String = ""
    var itemColorToSend: String = ""
    var itemIDToSend: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        userEmail = emailFromPeopleSearch
        getUserInfo()
    }
    
    func getUserInfo() {
        let dbRef = Database.database().reference()
        dbRef.child(firUsersNode).observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists() {
                if let userids = snapshot.value as? [String:AnyObject] {
                    for key in userids.keys {
                        let user = userids[key]!
                        let email = user[firEmailNode] as! String
                        if email == self.userEmail {
                            self.username = (user[firUsernameNode] as? String)!
                            self.usernameLabel.text = self.username
                            self.friendList = (user[firFriendListNode] as? [String])!
                            self.itemList = (user[firItemListNode] as? [String])!
                        }
                    }
                    
                }
            }
        })
    }
    
    func getItems() {
        let dbRef = Database.database().reference()
        dbRef.child(firItemsNode).observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists() {
                if let itemids = snapshot.value as? [String:AnyObject] {
                    for key in itemids.keys {
                        if self.itemList.contains(key) {
                            let item = itemids[key]!
                            let color = item[firColorNode] as? String
                            let itemname = item[firItemNameNode] as? String
                            let link = item[firLinkNode] as? String
                            let size = item[firSizeNode] as? String
                            let currItem = Item(itemName: itemname!, itemURL: link!, itemSize: size!, itemColor: color!, itemID: key)
                            self.items.append(currItem)
                        }
                    }
                    
                }
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? UserCopyTableViewCell else {
            return UITableViewCell()
        }
        cell.itemNameLabel.text = items[indexPath.row].itemName
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemNameToSend = items[indexPath.row].itemName
        itemURLToSend = items[indexPath.row].itemURL
        itemSizeToSend = items[indexPath.row].itemSize
        itemColorToSend = items[indexPath.row].itemColor
        itemIDToSend = items[indexPath.row].itemID
        performSegue(withIdentifier: "usercopy-itemcopy", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let VCHeadedTo = segue.destination as? ItemCopyVC {
            VCHeadedTo.itemNameFromUserCopy = itemNameToSend
            VCHeadedTo.itemURLFromUserCopy = itemURLToSend
            VCHeadedTo.itemSizeFromUserCopy = itemSizeToSend
            VCHeadedTo.itemColorFromUserCopy = itemColorToSend
            VCHeadedTo.itemIDFromUserCopy = itemIDToSend
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

