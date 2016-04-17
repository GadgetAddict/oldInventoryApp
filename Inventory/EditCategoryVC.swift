//
//  EditCategoryVC.swift
//  Inventory
//
//  Created by Michael King on 4/8/16.
//  Copyright © 2016 Michael King. All rights reserved.
//

import UIKit
import Firebase

class EditCategoryVC: UITableViewController {
 
 
    
    @IBOutlet weak var newCategoryTextField: UITextField!
    
    @IBAction func cancelButton(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func save(sender: AnyObject) {
        let txt = newCategoryTextField.text
      
     
        let newCatTrimmed = txt!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        let key = newCatTrimmed.lowercaseString
        
        
        var newCatStartingNumber: Int!
            DataService.ds.REF_CATEGORY.queryOrderedByChild("startingNumber").queryLimitedToLast(1).observeSingleEventOfType(.ChildAdded, withBlock: { snapshot in
                if let lastCatStartingNumber = snapshot.value["startingNumber"] as? Int {
                    if lastCatStartingNumber == 1 {
                        newCatStartingNumber = lastCatStartingNumber + 99

                    } else {
                        newCatStartingNumber = lastCatStartingNumber + 100
 
                    }
                    
                    print("lastStarting Number: \(lastCatStartingNumber)")
                    print("NEW Number: \(newCatStartingNumber)")

                    }
            }
        )
        if newCatStartingNumber == nil {
           newCatStartingNumber = 1
            print("new number from scratch: \(newCatStartingNumber)")
        }

        
                
 
 
    print("lets FB this \(newCatStartingNumber)")
        if newCatStartingNumber != nil {
                let newCat = ["catName":newCatTrimmed,   "startingNumber" : newCatStartingNumber]
                
                let firebasePost = DataService.ds.REF_CATEGORY.childByAppendingPath(key)
                
                firebasePost.setValue(newCat)
 
        
                // create an initial empty box for new category
                
                let firebaseRef = DataService.ds.REF_BOXES
                
                let newBox = ["boxNum": newCatStartingNumber, "fragile": "false", "boxCategory": newCatTrimmed, "status": "empty", "location":"none", "location_detail":"none", "location_shelf":"none"]
                
                let newboxRef = firebaseRef.childByAutoId()
                newboxRef.setValue(newBox)
        }
  
        
                self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
 


    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            newCategoryTextField.becomeFirstResponder()
            }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
   
   
}
