//
//  BoxContentsCell.swift
//  Inventory
//
//  Created by Michael King on 4/13/16.
//  Copyright © 2016 Michael King. All rights reserved.
//

import UIKit
import Firebase
import Alamofire


class BoxContentsCell: UITableViewCell {
 
    var item: Item!
        var request: Request?
        
        @IBOutlet weak var nameLbl: UILabel!
        @IBOutlet weak var categoryLbl: UILabel!
        @IBOutlet weak var subCategoryLbl: UILabel!
        @IBOutlet weak var imgFragile: UIImageView!
        
        override func awakeFromNib() {
            super.awakeFromNib()
            
        }//awakeFromNib
        
        
        func configureBoxCell(item: Item ) {
            self.item = item
            
            self.nameLbl.text = item.itemName
            self.categoryLbl.text = "\(item.itemCategory!)"
            self.subCategoryLbl.text = "\(item.itemSubcategory!)"
            
            
            
            //check if fragile, show image or don't
            
            //        if item.itemFragile == false {
            //            self.imgFragile.hidden = true
            //        }//ifFragile
            
        }//ConfigureCell
        
        
     func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("segue was called")
        if segue.identifier == "SendDataSegue" {
            
            if let destination = segue.destinationViewController as? SubcategoryVC {
           
                let cat = self.nameLbl.text
                destination.passedCategory = cat!.lowercaseString
            }
        }
    }
        
        
}//BoxContents class









