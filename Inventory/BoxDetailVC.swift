//
//  BoxDetailVC.swift
//  Inventory
//
//  Created by Michael King on 4/13/16.
//  Copyright © 2016 Michael King. All rights reserved.
//



import UIKit
import Firebase
import ActionSheetPicker_3_0


    class BoxDetailVC: UIViewController, UITableViewDataSource, UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
     
        let tealColor = UIColor(red: 0, green: 180, blue: 225)
        let grayColor = UIColor(red: 205, green: 205, blue: 205)
        
         var items = [Item]()
        
        var passedBoxNumber: String!
        
        @IBOutlet weak var tableView: UITableView!
        
        @IBOutlet weak var boxNumberLbl: UILabel!
        
        @IBOutlet weak var categoryLbl: UIButton!
        
        @IBOutlet weak var statusLbl: UIButton!
        
        
       
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            tableView.dataSource = self
            tableView.delegate = self
            tableView.estimatedRowHeight = 115
            
            DataService.ds.REF_BOXES.queryOrderedByChild("boxNum").queryEqualToValue(passedBoxNumber)
                .observeEventType(.ChildAdded, withBlock: { snapshot in
                    
                                     })
                
                //now look into that box for all the items 
              DataService.ds.REF_BOXES.childByAppendingPath(passedBoxNumber).observeEventType(.Value, withBlock: { snapshot in

                self.items = []
                if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                    
                    for snap in snapshots {
                        print("SNAP: \(snap)")
                        
                        if let itemDict = snap.value as? Dictionary<String, AnyObject> {
                            let key = snap.key
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
            
            if let cell = tableView.dequeueReusableCellWithIdentifier("BoxContentsCell") as?  BoxContentsCell {
                
          
                cell.configureBoxCell(item)
                
                return cell
            } else {
                return ItemCell()
            }
            
            
        }//tableView
        
        
        
            var passedQR: String?
            var status = [String]()         // stores status options
            var categories = [String]()     // stores category names
            var location = [String]()     // stores location options
        
        
            let statusOptions = ["Empty", "Packed", "Stored", "Damaged"]
            @IBAction func backBtn(sender: AnyObject) {
                navigationController!.popViewControllerAnimated(true)
            }
        
            func picker(title:String, rowItems: AnyObject, sender: AnyObject) {
        
            ActionSheetStringPicker.showPickerWithTitle(title, rows: rowItems as! [AnyObject], initialSelection: 0, doneBlock: {
            picker, value, index in
            //self.getLastBoxNumber(value)
           // self.newBoxCategory = index as! String
            return value
            }, cancelBlock: { ActionStringCancelBlock in return }, origin: sender)
        
        }
        
            @IBAction func statusBtn(sender: AnyObject) {
        
        
            ActionSheetStringPicker.showPickerWithTitle("Choose Category", rows: statusOptions, initialSelection: 0, doneBlock: {
            picker, value, index in
        
                self.statusLbl.setTitle(self.statusOptions[value], forState: UIControlState.Normal)
        
            return
            }, cancelBlock: { ActionStringCancelBlock in return }, origin: sender)
        
            }
        
        
        func loadFromFirebase(list: String) {
        
            DataService.ds.REF_CATEGORY.queryOrderedByChild(list).observeEventType(.ChildAdded, withBlock: { snapshot in
        
                var listName = ""
                let items = snapshot.value[listName] as! String
        
                //status, location, location detail, location area,
        
                var result = ""
        
                switch(list) {
                case "one":
                    result = "1"
                case "status":
                    result = "somethihg"
                default:
                    result = ""
                }
        
            })
            
        
 
        
        //         ///  Get FireBase Data to load Items into Table
        //
        //
        //    // List the names of all Mary's groups
        //    let ref = Firebase(url: "https://docs-examples.firebaseio.com/web/org")
        //    
        //    // fetch a list of Mary's groups
        //    ref.childByAppendingPath("users/mchen/groups").observeEventType(.ChildAdded, withBlock: {snapshot in
        //        // for each group, fetch the name and print it
        //        let groupKey = snapshot.key
        //        ref.childByAppendingPath("groups/\(groupKey)/name").observeSingleEventOfType(.Value, withBlock: {snapshot in
        //            print("Mary is a member of this group: \(snapshot.value)")
        //        })
        //    })
        //    
        //    
 
       
        
        }
        
}//BoxDetailFeedVC




