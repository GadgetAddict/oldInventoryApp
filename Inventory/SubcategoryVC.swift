//
//  adminSubcategory.swift
//  Inventory
//
//  Created by Michael King on 4/9/16.
//  Copyright © 2016 Michael King. All rights reserved.
//

import UIKit
import Firebase


protocol DestinationViewDelegate {
    func setCats(subcategory: String)
    
    }
    
    
class SubcategoryVC: UITableViewController {
    
    var delegate: DestinationViewDelegate! = nil
   
    var passedCategory : String! = nil
    
        @IBAction func cancelButton(sender: AnyObject) {
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }
        
        var items = [NSDictionary]()
        
        // MARK: - viewDidLoad
        override func viewDidLoad() {
            super.viewDidLoad()
            loadDataFromFirebase()
            print("Passed Category: \(passedCategory)")
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
                    print("Snaps: \(snap)")
                    let child = snap as! FDataSnapshot
                    let dict = child.value as! NSDictionary
                    tempArray.append(dict)
                }
                
                self.items = tempArray
                self.tableView.reloadData()
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                
            })
    }
            override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
                let dict = items[indexPath.row]
                
                  let selectedSub = dict["subname"] as! String
                let selectedCrap = dict[value]
                
                delegate.setCats(selectedSub)
                print("afer the delegate")
                self.navigationController?.popToRootViewControllerAnimated(true)
          
                }
    

    
 
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("lets add new SUBS")
        
        if segue.identifier == "SendSubCatDataSegue" {
     
            if let destination = segue.destinationViewController as? NewSubcategoryVC {
                
              destination.passedCat = (passedCategory)!
              
            }
        }
    }
    
//            override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//                if segue.identifier == "SaveSelectedGame" {
//                    if let cell = sender as? UITableViewCell {
//                        let indexPath = tableView.indexPathForCell(cell)
//                        if let index = indexPath?.row {
//                            print(index)
//                            selectedGame = games[index]
//                            print(selectedGame)
//                        }
//    
} //end class