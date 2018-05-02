//
//  FriendFeedVC.swift
//  PriceTracker
//
//  Created by Michelle Cheung on 4/4/18.
//  Copyright © 2018 MAE. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class FriendFeedVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var friendList: [String] = [] // List of user ids
    var friendNames: [String] = []
    var recentItemList: [String] = [] // List of item ids
    var recentItemNames: [String] = []
    var friendIDToSend: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        getFriendIDs()
        getFriendNamesAndRecentItemIDs()
        getRecentItemNames()
    }
    
    @IBAction func searchButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "feed-search", sender: self)
    }
    
    func getFriendIDs() {
        let dbRef = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        dbRef.child(firUsersNode).observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists() {
                if let userids = snapshot.value as? [String:AnyObject] {
                    let user = userids[userID!]!
                    self.friendList = (user[firFriendListNode] as? [String])!
                }
            }
        })
    }
    
    func getFriendNamesAndRecentItemIDs() {
        let dbRef = Database.database().reference()
        dbRef.child(firUsersNode).observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists() {
                if let userids = snapshot.value as? [String:AnyObject] {
                    self.friendNames = []
                    self.recentItemList = []
                    for key in userids.keys {
                        if self.friendList.contains(key) {
                            self.friendNames.append((userids[key]![firUsernameNode] as? String)!)
                            let itemListNode = userids[key]![firItemListNode] as? [String]
                            self.recentItemList.append(itemListNode![itemListNode!.count - 1])
                        }
                    }
                }
            }
        })
    }
    
    func getRecentItemNames() {
        let dbRef = Database.database().reference()
        dbRef.child(firItemsNode).observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists() {
                if let itemids = snapshot.value as? [String:AnyObject] {
                    self.recentItemNames = []
                    for key in itemids.keys {
                        if self.recentItemList.contains(key) {
                            self.recentItemNames.append((itemids[key]![firItemNameNode] as? String)!)
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
        return recentItemNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? FriendFeedTableViewCell else {
            return UITableViewCell()
        }
        cell.itemLabel.text = recentItemNames[indexPath.row]
        cell.usernameLabel.text = friendNames[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        friendIDToSend = friendList[indexPath.row]
        performSegue(withIdentifier: "feed-user", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let VCHeadedTo = segue.destination as? UserVC {
            VCHeadedTo.friendIDFromFriendFeed = friendIDToSend
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getFriendIDs()
        getFriendNamesAndRecentItemIDs()
        getRecentItemNames()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
