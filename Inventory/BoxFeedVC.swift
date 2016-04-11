//
//  WineTableVC.swift
//  Inventory
//
//  Created by Michael King on 4/3/16.
//  Copyright © 2016 Michael King. All rights reserved.
//

import UIKit

class BoxFeedVC: UITableViewController, UISearchResultsUpdating {
    
    let appleProducts = ["Mac", "iPhone", "Apple Watch", "iPad"]
    var filteredAppleProducts = [String]()
    var resultSearchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            
            self.tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
        
        // Reload the table
        self.tableView.reloadData()
    }

 
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       
        if self.resultSearchController.active {
            
            return self.filteredAppleProducts.count
            
            } else {
            
            return self.appleProducts.count
            
        }
    }
    
 
     override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
     
        let cell = tableView.dequeueReusableCellWithIdentifier("BoxCell", forIndexPath: indexPath) as UITableViewCell
        
        if (self.resultSearchController.active) {
            cell.textLabel?.text = self.filteredAppleProducts[indexPath.row]
                
            } else {
                
            cell.textLabel?.text = self.appleProducts[indexPath.row]
 
            
            }
            
            return cell
            
        }

    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        filteredAppleProducts.removeAll(keepCapacity: false)
        
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        
        let array = (appleProducts as NSArray).filteredArrayUsingPredicate(searchPredicate)
        
        filteredAppleProducts = array as! [String]
        
        self.tableView.reloadData()
    }
    
    
    
    
    
    
    
    
    
    }
