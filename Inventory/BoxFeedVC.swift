//
//  BoxFeedVC
//  Inventory
//
//  Created by Michael King on 4/3/16.
//  Copyright © 2016 Michael King. All rights reserved.
//

import UIKit
import Firebase
import ActionSheetPicker_3_0
import SwiftOverlays

class BoxFeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate {
let tealColor = UIColor(red: 0, green: 180, blue: 225)
let grayColor = UIColor(red: 205, green: 205, blue: 205)

    @IBOutlet var annoyingNotificationView: UIView?
 
    
    @IBOutlet weak var newBoxButton: styledButton!
    @IBOutlet weak var saveButtonOutlet: styledButton!
    
    var nextBoxNumber: Int!
    var categories = [String]()     // stores category names
    var catStartNumber = [Int]()    //stores category start numbers for adding new boxes
    var newBoxCategory : String!
    
    
    
    @IBAction func doneBtn(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
  }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var newBoxLbl: UILabel!
    
    @IBAction func newBoxBtn(sender: UIButton) {
     
        //change color of buttons
        self.saveButtonOutlet.backgroundColor = self.grayColor
        
        ActionSheetStringPicker.showPickerWithTitle("Choose Category", rows: categories, initialSelection: 0, doneBlock: {
             picker, value, index in
            self.getLastBoxNumber(value)
            self.newBoxCategory = index as! String
            return
            }, cancelBlock: { ActionStringCancelBlock in return }, origin: sender)
 
    }//end newBoxBtn
    
    func getLastBoxNumber (category: Int!) {
 
             let categoryStartingNumber = catStartNumber[category]
            print("CategoryStarting NUmber\(categoryStartingNumber)")
        
        
        
                  DataService.ds.REF_BOXES.observeEventType(.Value, withBlock: { snapshot in
                    if snapshot.value is NSNull {
                                  print("snapshotValue is NULL")
                        self.nextBoxNumber = categoryStartingNumber

                    } else {
         
                   let endingNum = categoryStartingNumber + 99
                DataService.ds.REF_BOXES.queryOrderedByChild("boxNum").queryLimitedToLast(1).queryStartingAtValue(categoryStartingNumber).queryEndingAtValue(endingNum).observeEventType(.ChildAdded, withBlock: { snapshot in
                    
                    if let temp = snapshot.value["boxNum"] as? Int {
          
                        
                // add 1 to last box number to make the next box number to be created
                  self.nextBoxNumber = temp + 1
                        self.newBoxLbl.text = "Number \(self.nextBoxNumber)"
                    }

                    }
                )
                   
                    }
        }
    )
        print("nextBoxDummy \(self.nextBoxNumber)")
        self.newBoxButton.backgroundColor = self.grayColor
        self.saveButtonOutlet.backgroundColor = self.tealColor
    
}//end func
    
    
        
        
        
    

    
    @IBAction func saveBoxBtn(sender: AnyObject) {
        
        self.newBoxButton.backgroundColor = self.tealColor
        self.saveButtonOutlet.backgroundColor = self.grayColor
        self.newBoxLbl.text = ""

        let firebaseRef = DataService.ds.REF_BOXES
        
        let newBox = ["boxNum": self.nextBoxNumber, "fragile": "false", "boxCategory": self.newBoxCategory, "status":"empty", "location":"none", "location_detail":"none", "location_shelf":"none"]
        
        let newboxRef = firebaseRef.childByAutoId()
        newboxRef.setValue(newBox)
     self.tableView.reloadData()
    }
    
  
    var boxes = [Box]()
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
           

            loadCatsFromFirebase()
               newBoxLbl.text = ""
            tableView.dataSource = self
            tableView.delegate = self
            tableView.estimatedRowHeight = 158
            
            
             DataService.ds.REF_BOXES.queryOrderedByChild("boxNum").observeEventType(.Value, withBlock:   { snapshot in
                
                self.boxes = []
                if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                    
                    for snap in snapshots {
                       print("SNAP: \(snap)")
                        
                        if let boxDict = snap.value as? Dictionary<String, AnyObject> {
                            let key = snap.key
                            let box = Box(boxKey: key, dictionary: boxDict)
                            self.boxes.append(box)
                        }
                    }
                }
                
                self.tableView.reloadData()
             })
    }
      // MARK: - Load Categories for New Box Method
   
    func loadCatsFromFirebase() {
        
        DataService.ds.REF_CATEGORY.queryOrderedByChild("catName").observeEventType(.ChildAdded, withBlock: { snapshot in
     
                let catNames = snapshot.value["catName"] as! String
                let startNum = snapshot.value["startingNumber"] as! Int
            
                self.categories.append(catNames)

                self.catStartNumber.append(startNum)
        })
    }

    

    
    
    
    
        // MARK: - Table view data source
    
         func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            
            return 1
        }
        
         func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
              return boxes.count
        }
        
        
         func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

            if let cell  = tableView.dequeueReusableCellWithIdentifier("BoxCell") as? BoxCell {
        
                    let box = boxes[indexPath.row]
                    cell.configureCell(box)
                
                    
                    return cell
                } else {
                        return BoxCell()
                    }
 }//tableView
    
   
  
   
    
        
        var beginTimer: NSTimer?
        var endTimer: NSTimer?
        
        var progress = 0.0
        
    
    
    
        override func viewWillDisappear(animated: Bool) {
            super.viewWillDisappear(animated)
            
            if let beginTimer = beginTimer {
                beginTimer.invalidate()
            }
            
            if let endTimer = endTimer {
                endTimer.invalidate()
            }
            
            SwiftOverlays.removeAllBlockingOverlays()
        }
        
        // MARK: begin notification
        func begin() {
            
            
            NSBundle.mainBundle().loadNibNamed("AnnoyingNotification", owner: self, options: nil)
            annoyingNotificationView!.frame.size.width = self.view.bounds.width;
            
            UIViewController.showNotificationOnTopOfStatusBar(annoyingNotificationView!, duration: 5)
            // Or SwiftOverlays.showAnnoyingNotificationOnTopOfStatusBar(annoyingNotificationView!, duration: 5)
            
      
            
            
            
            if let endTimer = endTimer {
                endTimer.invalidate()
            }
            
            endTimer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(end), userInfo: nil, repeats: false)
        }
        
        func end() {
            
            
            if let beginTimer = beginTimer {
                beginTimer.invalidate()
            }
            
            beginTimer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: #selector(begin), userInfo: nil, repeats: false)
        }
    
 
 
}
