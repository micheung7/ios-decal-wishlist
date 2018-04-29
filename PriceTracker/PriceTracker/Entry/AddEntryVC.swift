//
//  AddEntryVC.swift
//  PriceTracker
//
//  Created by Michelle Cheung on 4/4/18.
//  Copyright © 2018 MAE. All rights reserved.
//

import UIKit
import Foundation
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addItem(itemName: String, itemLink: String, itemSize: String, itemColor: String) {
        let dbRef = Database.database().reference()
        
        let itemAttr : [String:String] = ["name" : itemName,
                                             "link" : itemLink,
                                             "size": itemSize,
                                             "color": itemColor]
        
        dbRef.child("Posts").childByAutoId().setValue(itemAttr)
        //dbRef.child("")
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
