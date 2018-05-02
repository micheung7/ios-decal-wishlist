//
//  ProfileVC.swift
//  PriceTracker
//
//  Created by Michelle Cheung on 4/4/18.
//  Copyright © 2018 MAE. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import MBProgressHUD
import FirebaseAuth

class ProfileVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileImage: UIImageView!
    
    var IDList: [String] = []
    var ItemList: [Item] = []
    var itemToSend: Item? = nil
    
    @IBAction func Add(_ sender: Any) {
        performSegue(withIdentifier: "profile-addentry", sender: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.profileImage.image = #imageLiteral(resourceName: "shopping cart.jpg")
        getUserItemID()
        setItems()
    }
    
    func getUserItemID() {
        let dbRef = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        dbRef.child(firUsersNode).observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists() {
                if let userids = snapshot.value as? [String:AnyObject] {
                    let user = userids[userID!]!
                    self.IDList = (user[firItemListNode] as? [String])!
                }
            }
        })
    }
    
    func setItems() {
        let dbRef = Database.database().reference()
        dbRef.child(firItemsNode).observeSingleEvent(of: .value, with: {(snapshot) in
            if snapshot.exists() {
                if let itemids = snapshot.value as? [String:AnyObject] {
                    self.ItemList = []
                    for key in itemids.keys {
                        if self.IDList.contains(key) {
                            let item = itemids[key]!
                            let color = item[firColorNode] as? String
                            let itemname = item[firItemNameNode] as? String
                            let link = item[firLinkNode] as? String
                            let size = item[firSizeNode] as? String
                            let currItem = Item(itemName: itemname!, itemURL: link!, itemSize: size!, itemColor: color!, itemID: key)
                            self.ItemList.append(currItem)
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
        return ItemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? ProfileTableViewCell else {
            return UITableViewCell()
        }
        cell.itemNameLabel.text = ItemList[indexPath.row].itemName
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemToSend = ItemList[indexPath.row]
        performSegue(withIdentifier: "profile-itemedit", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let VCHeadedTo = segue.destination as? ItemEditVC {
            VCHeadedTo.itemFromProfile = itemToSend
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getUserItemID()
        setItems()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
