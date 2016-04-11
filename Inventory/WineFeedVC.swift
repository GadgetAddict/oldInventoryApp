//
//  WineTableVC.swift
//  Inventory
//
//  Created by Michael King on 4/3/16.
//  Copyright © 2016 Michael King. All rights reserved.
//

import UIKit
import Firebase

class WineFeedVC: UITableViewController, UINavigationControllerDelegate {
 
    
    var wines = [Wine]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        DataService.ds.REF_CELLAR.observeEventType(.Value, withBlock:   { snapshot in
            
            self.wines = []
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                
                for snap in snapshots {
                    print("SNAP: \(snap)")
                    
                    if let wineDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let wine = Wine(wineKey: key, dictionary: wineDict)
                        self.wines.append(wine)
                    }
                }
            }
            
            self.tableView.reloadData()
        })
    }
 
 

    // MARK: - Table view data source

     override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }

     override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return wines.count
    }

   
     override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    

        let wine = wines[indexPath.row]
        
        if let cell  = tableView.dequeueReusableCellWithIdentifier("WineCell") as? WineCell {
            
            cell.configureCell(wine)
            
        return cell
        } else {
            return WineCell()
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
