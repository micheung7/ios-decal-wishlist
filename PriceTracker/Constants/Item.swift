//
//  Item.swift
//  PriceTracker
//
//  Created by Emily Hill on 4/25/18.
//  Copyright © 2018 MAE. All rights reserved.
//

import Foundation
import UIKit

class Item {
    // Name of the item
    var itemName: String
    
    // Optional website link to the item
    var itemURL: String
    
    // Size of the item
    var itemSize: String
    
    // Optional color of the item
    var itemColor: String
    
    // ID of the post, generated automatically on Firebase
    var postID: String
    //var itemAddress
    
    // Designated initializer for posts
    // Parameters:
    //      - itemName: Name of Item
    //      - itemURL: Optional website link to the product page
    //      - itemSize:
    //      - itemColor:
    //      - postID:
    init(itemName: String, itemURL: String, itemSize: String, itemColor: String, postID: String) {
        self.itemName = itemName
        self.itemURL = itemURL
        self.itemSize = itemSize
        self.itemColor = itemColor
        self.postID = postID
    }
}
