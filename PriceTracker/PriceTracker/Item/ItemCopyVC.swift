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

    var itemFromUserCopy: Item? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemNameLabel.text = itemFromUserCopy?.itemName
        sizeLabel.text = itemFromUserCopy?.itemSize
        colorLabel.text = itemFromUserCopy?.itemColor
        linkLabel.text = itemFromUserCopy?.itemURL
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
