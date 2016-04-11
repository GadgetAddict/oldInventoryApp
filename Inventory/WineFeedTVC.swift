//
//  WineFeedTVC.swift
//  Inventory
//
//  Created by Michael King on 4/7/16.
//  Copyright © 2016 Michael King. All rights reserved.
//

import UIKit

class WineFeedTVC: UITableViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var wines = [Wine]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
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
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return wines.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let wine = wines[indexPath.row]
        
        if let cell  = tableView.dequeueReusableCellWithIdentifier("WineCell") as? WineCell {
            
            cell.configureCell(wine)
            
            return cell
        } else {
            return WineCell()
        }
    }
    
    
}
