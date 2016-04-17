//
//  colorsVC.swift
//  Inventory
//
//  Created by Michael King on 4/7/16.
//  Copyright © 2016 Michael King. All rights reserved.
//

import UIKit

class colorsVC: UITableViewController {
        
        var colors:[String] = [
            "RGB",
            "Red",
            "Green",
            "Blue",
            "Warm White",
            "Cool White"       ]
        
        var selectedColor:String? {
            didSet {
                if let color = selectedColor {
                    selectedColorIndex = colors.indexOf(color)!
                }
            }
        }
        var selectedColorIndex:Int?
        
        // MARK: - Table view data source
        
        override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            return 1
        }
        
        override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return colors.count
        }
        
        override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("ColorCell", forIndexPath: indexPath)
            cell.textLabel?.text = colors[indexPath.row]
            
            if indexPath.row == selectedColorIndex {
                cell.accessoryType = .Checkmark
            } else {
                cell.accessoryType = .None
            }
            return cell
        }
        
        override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            
            //Other row is selected - need to deselect it
            if let index = selectedColorIndex {
                let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0))
                cell?.accessoryType = .None
            }
            
            selectedColor = colors[indexPath.row]
            
            //update the checkmark for the current row
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            cell?.accessoryType = .Checkmark
        }
        
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            if segue.identifier == "SaveSelectedColor" {
                if let cell = sender as? UITableViewCell {
                    let indexPath = tableView.indexPathForCell(cell)
                    if let index = indexPath?.row {
                      
                        selectedColor = colors[index]
                                            }
                }
            }
        }
}