//
//  ItemCopyVC.swift
//  PriceTracker
//
//  Created by Michelle Cheung on 4/4/18.
//  Copyright © 2018 MAE. All rights reserved.
//

import UIKit

class ItemCopyVC: UIViewController {
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var linkLabel: UILabel!
    
    var itemNameFromUserCopy: String = ""
    var itemURLFromUserCopy: String = ""
    var itemSizeFromUserCopy: String = ""
    var itemColorFromUserCopy: String = ""
    var itemIDFromUserCopy: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemNameLabel.text = itemNameFromUserCopy
        sizeLabel.text = itemSizeFromUserCopy
        colorLabel.text = itemColorFromUserCopy
        linkLabel.text = itemURLFromUserCopy
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
