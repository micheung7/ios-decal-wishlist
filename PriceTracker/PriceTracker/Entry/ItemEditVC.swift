//
//  ItemEditVC.swift
//  PriceTracker
//
//  Created by Michelle Cheung on 4/4/18.
//  Copyright © 2018 MAE. All rights reserved.
//

import UIKit

class ItemEditVC: UIViewController {
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var deleteEditButton: UIButton!
    
    var itemFromProfile: Item? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemNameLabel.text = itemFromProfile?.itemName
        sizeLabel.text = itemFromProfile?.itemSize
        colorLabel.text = itemFromProfile?.itemColor
        linkLabel.text = itemFromProfile?.itemURL
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
