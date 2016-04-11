//
//  adminCategoryVC.swift
//  Inventory
//
//  Created by Michael King on 4/8/16.
//  Copyright © 2016 Michael King. All rights reserved.
//

import UIKit
import Firebase

class CategoryVC: UITableViewController {
 
    
  
    @IBAction func cancelButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)

    }
    
        var items = [NSDictionary]()
    
        // MARK: - viewDidLoad
        override func viewDidLoad() {
            super.viewDidLoad()
            loadDataFromFirebase()
        }
    
        
        // MARK: - Table view data source
        
        override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            return 1
        }
        
        override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return items.count
        }
        
        override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("adminCatCell", forIndexPath: indexPath)
            
            configureCell(cell, indexPath: indexPath)
            
            return cell
        }
        
        override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            let dict = items[indexPath.row]
            let name = dict["catName"] as! String
            
            // delete data from firebase
            
            let catRef = DataService.ds.REF_CATEGORY.childByAppendingPath(name)
            catRef.removeValue()
        }
    }
    
        // MARK:- Configure Cell
        
        func configureCell(cell: UITableViewCell, indexPath: NSIndexPath) {
            let dict = items[indexPath.row]
            
            cell.textLabel?.text = dict["catName"] as? String
      
        }
        
        
        // MARK:- Load data from Firebase
        
        func loadDataFromFirebase() {
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            
            DataService.ds.REF_CATEGORY.observeEventType(.Value, withBlock: { snapshot in
            
                var tempArray = [NSDictionary]()
                
                for snap in snapshot.children {
                    print("SnapCat: \(snap)")
                    let child = snap as! FDataSnapshot
                    let dict = child.value as! NSDictionary
                    tempArray.append(dict)
                }
                
                self.items = tempArray
                self.tableView.reloadData()
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                
            })
        }
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        _ = tableView.indexPathForSelectedRow!
//        if let _ = tableView.cellForRowAtIndexPath(indexPath) {
//            self.performSegueWithIdentifier("SendDataSegue", sender: self)
//        }
//        
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       print("segue was called")
        
        if segue.identifier == "SendDataSegue" {
       
            if let destination = segue.destinationViewController as? SubcategoryVC {
                
                let path = tableView.indexPathForSelectedRow
                let cell = tableView.cellForRowAtIndexPath(path!)
                destination.passedCategory = (cell?.textLabel?.text!)!
                print("passing Category to subcategory VC:  \(cell?.textLabel?.text!)")
            }
        }
    }
} //end class