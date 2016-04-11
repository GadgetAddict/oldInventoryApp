//
//  Box.swift
//  Inventory
//
//  Created by Michael King on 4/1/16.
//  Copyright © 2016 Michael King. All rights reserved.
//

import Foundation
import Firebase

class Box  {
    private var _boxKey: String!
    private var _boxRef: Firebase!
    private var _boxNumber: Int!
    private var _boxFragile: Bool!
    private var _boxDescript: String?
    private var _boxLocationGeo: String!
    private var _boxLocationDetail: String?
    private var _boxLocationShelf: String?
    
    
    var boxKey: String! {
        return _boxKey
    }
    
    var boxNumber:Int {
        return _boxNumber
    }
    
    var boxFragile:Bool {
        return _boxFragile
    }
    
    var boxDescript:String? {
        return _boxDescript
    }
    
    var boxLocationGeo:String {
        return _boxLocationGeo
    }
    
    var boxLocationDetail:String? {
        return _boxLocationDetail
    }
    
    var boxLocationShelf:String? {
        return _boxLocationShelf
    }
    
    
    init(number: String, fragile: Bool, description: String, located : String, locDetail: String, locShelf : String) {
        self._boxNumber = boxNumber
        self._boxFragile = fragile
        self._boxDescript = description
        self._boxLocationGeo = located
        self._boxLocationDetail = locDetail
        self._boxLocationShelf = locShelf
    }
    
    init (boxKey: String, dictionary: Dictionary <String, AnyObject>) {
        self._boxKey = boxKey
        
        if let fragile = dictionary["fragile"] as? Bool {
            self._boxFragile = fragile
        }
        
        if let description = dictionary["description"] as? String {
            self._boxDescript  =  description
        }
        
        if let boxNumber = dictionary["boxNumber"] as? Int {
             self._boxNumber = boxNumber
        }
        
        if let located = dictionary["location"] as? String {
            self._boxLocationGeo = located
        }
        
        if let locDetail = dictionary["location_detail"] as? String {
              self._boxLocationDetail = locDetail
        }
        
        if let locShelf = dictionary["location_shelf"] as? String {
              self._boxLocationShelf = locShelf
        }
        
        self._boxRef = DataService.ds.REF_BOXES.childByAppendingPath(self._boxKey)
    }
    
} // class





