//
//  itemFeedVC.swift
//  Inventory
//
//  Created by Michael King on 4/1/16.
//  Copyright © 2016 Michael King. All rights reserved.
//

import UIKit
import Firebase
import Alamofire



class itemFeedVC: UIViewController, UITableViewDataSource, UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var items = [Item]()
    
    static var imageCache = NSCache()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 115
  
    DataService.ds.REF_ITEMS.observeEventType(.Value, withBlock: { snapshot in
            
    self.items = []
    if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
            
            for snap in snapshots {
                print("SNAP: \(snap)")
            
            if let itemDict = snap.value as? Dictionary<String, AnyObject> {
                let key = snap.key
               // print("HERE IS THE KEY: \(key)")
                let item = Item(itemKey: key, dictionary: itemDict)
                self.items.append(item)
                
            }
        }
        
    }
        
            self.tableView.reloadData()
        
    })
    
}





    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let item  = items[indexPath.row]
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell") as?  ItemCell {
            
            cell.request?.cancel()
            
            var img: UIImage?
            
            if let url = item.itemImgUrl {
                img = itemFeedVC.imageCache.objectForKey(url) as? UIImage
            }
            
            cell.configureCell(item, img: img)
            
            return cell
        } else {
            return ItemCell()
        }

         
    }//tableView
    
    //edit/delete
//     func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == .Delete {
//            
//            let dict = items[indexPath.row]
//            let key = dict.itemName
//            print("DEBUG TIME")
//            print(key)
//            // delete data from firebase
//            
//            let catRef = DataService.ds.REF_ITEMS.childByAppendingPath(key)
//            catRef.removeValue()
//        }
//    }
    
    
    
 
    // Mark: Unwind Segues
    @IBAction func saveNewItemBackToFeed(segue:UIStoryboardSegue) {
        if let newItemViewController = segue.sourceViewController as? NewItemVC {
            
        }
    }
    
 
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ToItemDetails" {
            if let cell = sender as? UITableViewCell {
                let indexPath = tableView.indexPathForCell(cell)
                let dict = items[indexPath!.row]
                let itemKey =  dict.itemKey
                if let destination = segue.destinationViewController as? itemDetailsVC {
                    destination.passedItem = (itemKey)!
                    print("I have the key: \(itemKey)")
                    }
                }
            }
        }
 
    
    }//itemFeedVC


