//
//  Category.swift
//  Inventory
//
//  Created by Michael King on 4/12/16.
//  Copyright © 2016 Michael King. All rights reserved.
//


import Foundation


class Category {
    
    var catKey: String!
    var categoryName: String?
    var subcategoryName: String?
    var newCatStartingNumber : Int?
    var lastCatStartingNumber:  Int?
    
    
    
    
    
    init(categoryName: String?, subcategoryName: String?) {
        self.categoryName = categoryName
        self.subcategoryName = subcategoryName

    }

    init (catKey: String, dictionary: Dictionary <String, AnyObject> ) {
        self.catKey = catKey
    
        if let categoryName = dictionary["catName"] as? String {
            self.categoryName = categoryName
        }
        
        if let subcategoryName = dictionary["subName"] as? String {
            self.subcategoryName = subcategoryName
        }
        
        if let newCatStartingNumber = dictionary["newCatStartingNumber"] as? Int {
            self.newCatStartingNumber = newCatStartingNumber
        }
        
        if let lastCatStartingNumber = dictionary["lastCatStartingNumber"] as? Int {
            self.lastCatStartingNumber = lastCatStartingNumber
        }
        
    }
    

    
}
