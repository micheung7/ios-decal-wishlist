//
//  UserCopyTableViewCell.swift
//  PriceTracker
//
//  Created by Michelle Cheung on 4/5/18.
//  Copyright © 2018 MAE. All rights reserved.
//

import UIKit

class UserCopyTableViewCell: UITableViewCell {
    // Connect outlets
    @IBOutlet weak var itemNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
