//
//  mainMenuVC.swift
//  Inventory
//
//  Created by Michael King on 4/15/16.
//  Copyright © 2016 Michael King. All rights reserved.
//


import UIKit
import Firebase


class MainMenuVC: UITableViewController {

    
    
    @IBOutlet weak var boxesBtn: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        DataService.ds.REF_CATEGORY.observeEventType(.Value, withBlock: { snapshot in
            
            if snapshot.value is NSNull {
                print("There are no categories yet")
                
            }
            
        })
        
        
    }
    
  
    
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        view.endEditing(true)
//        super.touchesBegan(touches, withEvent: event)
//    }
//    
//    
//    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        if indexPath.section == 0 && indexPath.row == 0 {
//            newCategoryTextField.becomeFirstResponder()
//        }
//        tableView.deselectRowAtIndexPath(indexPath, animated: true)
//    }
    
    
    
}
