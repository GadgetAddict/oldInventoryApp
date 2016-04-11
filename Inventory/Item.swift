//
//  Item.swift
//  Inventory
//
//  Created by Michael King on 4/1/16.
//  Copyright © 2016 Michael King. All rights reserved.
//

import Foundation
import Firebase

class Item  {
    private var _itemRef: Firebase!
    private var _itemKey: String!
    private var _itemImgUrl: String?
    private var _itemName:String!
    private var _itemDescript: String?
    private var _itemCategory: Int?
    private var _itemSubcategory: Int?
    private var _itemBoxNum: Int?
    private var _itemQty: Int?
    private var _itemFragile: Bool!


    
    var itemName: String {
        return _itemName
    }
    
    var itemImgUrl: String? {
        return _itemImgUrl
    }

    var itemDescript: String? {
        return _itemDescript
    }
 

    var itemCategory: Int? {
        return _itemCategory
    }

    var itemSubcategory: Int? {
        return _itemSubcategory
    }

    var itemBoxNum: Int? {
        return _itemBoxNum
    }

    var itemQty: Int! {
        return _itemQty
    }

    var itemFragile: Bool {
        return _itemFragile
    }


    init(name: String, description: String, category: Int, subcategory: Int, qty: Int, fragile: Bool, itemInBox: Int) {
        self._itemName = name
        self._itemImgUrl = itemImgUrl
        self._itemDescript = description
        self._itemCategory = category
        self._itemSubcategory = subcategory
        self._itemBoxNum = itemInBox
        self._itemQty = qty
        self._itemFragile = fragile

        }

    init(itemKey: String, dictionary: Dictionary <String, AnyObject> ) {
        self._itemKey = itemKey
        
        if let itemImgUrl = dictionary["itemImgUrl"] as? String {
            self._itemImgUrl = itemImgUrl
        }
        if let itemName = dictionary["itemName"] as? String {
            self._itemName = itemName
        }
        if let description = dictionary["itemDescript"] as? String {
            self._itemDescript = description
        }
        if let category = dictionary["itemCategory"] as? Int {
            self._itemCategory = category
        }
        if let subcategory = dictionary["itemSubcategory"] as? Int {
            self._itemSubcategory = subcategory
        }
        if let itemInBox = dictionary["itemInBox"] as? Int {
            self._itemBoxNum = itemInBox
        }
        if let qty = dictionary["itemQty"] as? Int {
            self._itemQty = qty
        }
        if let fragile = dictionary["itemFragile"] as? Bool {
            self._itemFragile = fragile
        }
        self._itemRef = DataService.ds.REF_ITEMS.childByAppendingPath(self._itemKey)
       }
    
}






