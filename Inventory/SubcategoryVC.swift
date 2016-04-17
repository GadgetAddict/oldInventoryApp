//
//  adminSubcategory.swift
//  Inventory
//
//  Created by Michael King on 4/9/16.
//  Copyright © 2016 Michael King. All rights reserved.
//

import UIKit
import Firebase


    
    
class SubcategoryVC: UITableViewController {
    
   
    var category: Category?
    
    var passedCategory : String! = nil
    
    
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
            
            let cell = tableView.dequeueReusableCellWithIdentifier("adminSubcatCell", forIndexPath: indexPath)
            
            configureCell(cell, indexPath: indexPath)
            
            return cell
        }
        
        override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
            if editingStyle == .Delete {
                
                let dict = items[indexPath.row]
             //   let name = dict["subname"] as! String
                
                // delete data from firebase
                
              //  let subcatRef = DataService.ds.REF_CATEGORY.childByAppendingPath(passedCategory).childByAppendingPath(passedCat)
               // subcatRef.removeValue()
            }
        }
        
        // MARK:- Configure Cell
        
        func configureCell(cell: UITableViewCell, indexPath: NSIndexPath) {
            let dict = items[indexPath.row]
            
            cell.textLabel?.text = dict["subname"] as? String
            
        }
        
        
        // MARK:- Load data from Firebase
        
        func loadDataFromFirebase() {
            
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            
            DataService.ds.REF_CATEGORY.childByAppendingPath(passedCategory).childByAppendingPath("subcats").observeEventType(.Value, withBlock: { snapshot in
                
                var tempArray = [NSDictionary]()
                
                for snap in snapshot.children {
                    print("SnapSubCats: \(snap)")
                    let child = snap as! FDataSnapshot
                    let dict = child.value as! NSDictionary
                    tempArray.append(dict)
                }
                
                self.items = tempArray
                self.tableView.reloadData()
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                
            })
    }
     

    //Unwind segue
    @IBAction func unwindWithNewSubcat(segue:UIStoryboardSegue) {
       
    }
 
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
         if segue.identifier == "saveCategoryDetail" {
            if let cell = sender as? UITableViewCell {
                let indexPath = tableView.indexPathForCell(cell)
                let dict = items[indexPath!.row]
                let subname = dict["subname"] as! String
                
                    category = Category(categoryName: passedCategory, subcategoryName: subname)
              
                }
        }
  
        if segue.identifier == "SendSubCatDataSegue" {
            print("lets add new SUBS")

            if let destination = segue.destinationViewController as? NewSubcategoryVC {

            destination.passedCat = (passedCategory)!
                
            }
        }
    }
    
   
} //end class