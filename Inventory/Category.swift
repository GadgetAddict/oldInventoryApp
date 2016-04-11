//
//  category.swift
//  Inventory
//
//  Created by Michael King on 4/8/16.
//  Copyright © 2016 Michael King. All rights reserved.
//

import Foundation
import Firebase

class Category  {

    private var _catName:    String!
    private var _subcatName: String!
    private var _cat_Ref: Firebase!
    private var _cat_Key: String!

    
    var catName: String {
        return _catName
        
    }
    
    var subcatName: String {
        return _subcatName
    }
    
    
    var catKey: String {
        return _cat_Key
        
    }
    
    init(catName: String, subcatName: String ) {
        
        self._catName = catName
        self._subcatName = subcatName
    }
    
    init (catKey: String, dictionary: Dictionary <String, AnyObject>) {
        self._cat_Key = catKey
        
        if let catName = dictionary["catName"] as? String {
            self._catName = catName
        }
        
        if let subcatName = dictionary["subcatName"] as? String {
            self._subcatName = subcatName
        }
        
        self._cat_Ref = DataService.ds.REF_CATEGORY.childByAppendingPath(self._cat_Key)
    }

}