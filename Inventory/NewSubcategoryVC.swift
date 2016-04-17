//
//  NewSubcategoryVC.swift
//  Inventory
//
//  Created by Michael King on 4/9/16.
//  Copyright © 2016 Michael King. All rights reserved.
//

import UIKit
import Firebase

class NewSubcategoryVC: UITableViewController {
    
    
        var passedCat: String?
    
        @IBOutlet weak var newSubcategoryTextField: UITextField!
        
        @IBAction func cancelButton(sender: AnyObject) {
            navigationController?.popViewControllerAnimated(true)
            
        }
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
         
        }
        
        @IBAction func saveSubCat(sender: AnyObject) {
            let newSubcategory = newSubcategoryTextField.text
            let newSubTrimmed = newSubcategory!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
 
            let newSubcat = ["subname":newSubTrimmed]
            let firebasePost = DataService.ds.REF_CATEGORY.childByAppendingPath(passedCat).childByAppendingPath("subcats").childByAutoId()
            firebasePost.setValue(newSubcat)
            
            navigationController?.popViewControllerAnimated(true)
        }
    
        
        override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
            view.endEditing(true)
            super.touchesBegan(touches, withEvent: event)
        }
        
        
        
        override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            if indexPath.row == 0 {
                newSubcategoryTextField.becomeFirstResponder()
            }
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
        
    
}
