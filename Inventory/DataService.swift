//
//  DataService.swift
//  Inventory
//
//  Created by Michael King on 3/27/16.
//  Copyright © 2016 Michael King. All rights reserved.
//

import Foundation
import Firebase

let URL_BASE = "https://homeinventory.firebaseio.com/"

class DataService {
    static let ds = DataService()
    
    
    private var _REF_BASE = Firebase(url: "\(URL_BASE)")
    private var _REF_ITEMS = Firebase(url: "\(URL_BASE)/Items")
    private var _REF_BOXES = Firebase(url: "\(URL_BASE)/boxes")
    private var _REF_CATEGORY = Firebase(url: "\(URL_BASE)/categories")
    private var _REF_CELLAR = Firebase(url: "\(URL_BASE)/cellar")
    private var _REF_USERS = Firebase(url: "\(URL_BASE)/users")


    
    var REF_BASE: Firebase {
        return _REF_BASE
    }
    
    var REF_ITEMS: Firebase {
        return _REF_ITEMS
    }
    
    var REF_BOXES: Firebase {
        return _REF_BOXES
    }
    
    
    var REF_CELLAR: Firebase {
        return _REF_CELLAR
    }
    
    var REF_USERS: Firebase {
        return _REF_USERS
    }
    
    var REF_CATEGORY: Firebase {
         return _REF_CATEGORY
    }
    
   
 
    
    var REF_USER_CURRENT: Firebase {
        let uid = NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) as! String
        let user = Firebase(url: "\(URL_BASE)").childByAppendingPath("users").childByAppendingPath(uid)
        return user!
    }
    
    func createFirebaseUser(uid: String, user: Dictionary<String, String> ) {
        REF_USERS.childByAppendingPath(uid).setValue(user)
    }
    
} // end of class





