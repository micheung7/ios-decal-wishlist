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
    
    @IBAction func follow(_ sender: Any) {
        addFriend(uid: friendID)
        followUnfollowButton.setTitle("Following", for: .normal)
    }
    
    var emailFromPeopleSearch: String = ""
    var uid: String = ""
    var username = ""
    var userEmail = ""
    var friendList: [String] = [] // List of user ids
    var itemList: [String] = [] // List of item ids
    var items: [Item] = []
    var itemToSend: Item? = nil
    var friendID: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        uid = friendID
        userEmail = emailFromPeopleSearch
        self.userImage.image = #imageLiteral(resourceName: "shoppingCart")
        getUserInfo()
        getItems()
    }
    
    func addFriend(uid: String){
        let dbRef = Database.database().reference()
        let currentUserID = Auth.auth().currentUser?.uid
        if !friendList.contains(uid) {
            friendList.append(uid)
            dbRef.root.child("users").child(currentUserID!).updateChildValues(["friendList": friendList])
        }
        // Now add the item id to the itemList of current user
        
    }
    
    func checkFollowing() {
        if friendList.contains(friendID) {
            followUnfollowButton.setTitle("Following", for: .normal)
        }
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
                            self.checkFollowing()
                        }
                    }
                }
            }
        })
    }
    
    func getFriendInfo() {
        let dbRef = Database.database().reference()
        dbRef.child(firUsersNode).observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists() {
                if let userids = snapshot.value as? [String:AnyObject] {
                    for key in userids.keys {
                        let user = userids[key]!
                        let email = user[firEmailNode] as! String
                        if email == self.userEmail {
                            self.friendID = (user as? String)!
                            self.checkFollowing()
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
                    self.items = []
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
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        })
    }
    
    // Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
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
        itemToSend = items[indexPath.row]
        performSegue(withIdentifier: "usercopy-itemcopy", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let VCHeadedTo = segue.destination as? ItemCopyVC {
            VCHeadedTo.itemFromUserCopy = itemToSend
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getUserInfo()
        getItems()
        getFriendInfo()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

