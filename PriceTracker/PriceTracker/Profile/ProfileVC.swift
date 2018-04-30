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
    
    
    @IBAction func Add(_ sender: Any) {
        performSegue(withIdentifier: "profile-addentry", sender: self)
    }
    
    var IDList: [String] = []
    var ItemList: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        getUserItemID()
        setItems()

        // Do any additional setup after loading the view.
    }
    
    func getUserItemID() {
        var tempID: [String] = []
        let dbRef = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        dbRef.child(firUsersNode).child(userID!).child("itemList").observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists() {
                if let itemID = snapshot.value as? [String] {
                    for ID in itemID {
                        tempID.append(ID)
                    }
                    self.IDList = tempID
                }
            }
        })
    }
    
    func setItems() {
        var tempItems: [Item] = []
        var tempName: String!
        var tempSize: String!
        var tempColor: String!
        var tempLink: String!
        let dbRef = Database.database().reference()
        dbRef.child("items").observeSingleEvent(of: .value, with: {(snapshot) in
            if snapshot.exists() {
                if let ID = snapshot.value as? String {
                    if self.IDList.contains(ID) {
                        tempName = snapshot.childSnapshot(forPath: "itemname").value! as! String
                        tempSize = snapshot.childSnapshot(forPath: "size").value! as! String
                        tempColor = snapshot.childSnapshot(forPath: "color").value! as! String
                        tempLink = snapshot.childSnapshot(forPath: "link").value! as! String
                        let holder = Item.init(itemName: tempName, itemURL: tempLink, itemSize: tempSize, itemColor: tempColor, itemID: ID)
                        tempItems.append(holder)
                    }
                }
                self.ItemList = tempItems
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
        cell.sizeLabel.text = ItemList[indexPath.row].itemSize
        cell.colorLabel.text = ItemList[indexPath.row].itemColor
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "profile-addentry", sender: self)
    }

    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
