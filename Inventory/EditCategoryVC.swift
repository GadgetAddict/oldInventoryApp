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
        self.dismissViewControllerAnimated(true, completion: nil)

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func save(sender: AnyObject) {
           let newCategory = newCategoryTextField.text
        let newCategoryKey = newCategory
                newCategoryKey?.lowercaseString
            let newCat = ["catName":newCategory!]
            let firebasePost = DataService.ds.REF_CATEGORY.childByAppendingPath(newCategoryKey!)
            firebasePost.setValue(newCat)
    
        navigationController?.popViewControllerAnimated(true)
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
