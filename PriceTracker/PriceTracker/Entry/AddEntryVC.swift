//
//  AddEntryVC.swift
//  PriceTracker
//
//  Created by Michelle Cheung on 4/4/18.
//  Copyright © 2018 MAE. All rights reserved.
//

import UIKit
import Foundation
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class AddEntryVC: UIViewController {
    @IBOutlet weak var saveButton: UIButton! 
    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var linkTextField: UITextField!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var sizeTextField: UITextField!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var colorTextField: UITextField!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var notesTextField: UITextView!
    
    
    var name = String()
    var link = String()
    var size = String()
    var color = String()
    
    var itemIds = [String]()
    
    @IBAction func Save(_ sender: Any) {
        name = itemNameTextField.text!
        link = linkTextField.text!
        size = sizeTextField.text!
        color = colorTextField.text!
        addItem(itemName: name, itemLink: link, itemSize: size, itemColor: color)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.setTitle("Save", for: .normal)
        // Do any additional setup after loading the view.
        let dbRef = Database.database().reference()
        let currentUserID = Auth.auth().currentUser?.uid
        dbRef.child(firUsersNode).observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists() {
                if let userids = snapshot.value as? [String:AnyObject] {
                    self.itemIds = (userids[currentUserID!]![firItemListNode] as? [String]?)!!
                }
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addItem(itemName: String, itemLink: String, itemSize: String, itemColor: String) {
        let dbRef = Database.database().reference()
        let currentUserID = Auth.auth().currentUser?.uid
        
        // Creating a new item id with attributes
        let itemAttr : [String:String] = ["name" : itemName,
                                             "link" : itemLink,
                                             "size": itemSize,
                                             "color": itemColor]
        let newItemRef = dbRef.child("items").childByAutoId()
        let newItemId = newItemRef.key
        newItemRef.setValue(itemAttr)
        
        itemIds.append(newItemId)
        dbRef.root.child("users").child(currentUserID!).updateChildValues(["itemList" : itemIds])
        // Now add the item id to the itemList of current user
        
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
