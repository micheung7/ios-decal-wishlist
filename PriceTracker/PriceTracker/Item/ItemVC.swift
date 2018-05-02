//
//  ItemVC.swift
//  PriceTracker
//
//  Created by Michelle Cheung on 4/4/18.
//  Copyright © 2018 MAE. All rights reserved.
//

import UIKit

class ItemVC: UIViewController {
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var linkLabel: UILabel!
    
    var itemFromUser: Item? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemNameLabel.text = itemFromUser?.itemName
        sizeLabel.text = itemFromUser?.itemSize
        colorLabel.text = itemFromUser?.itemColor
        linkLabel.text = itemFromUser?.itemURL
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
