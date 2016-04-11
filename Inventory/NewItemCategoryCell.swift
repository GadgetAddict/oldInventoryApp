//
//  categoryCell.swift
//  Inventory
//
//  Created by Michael King on 4/7/16.
//  Copyright © 2016 Michael King. All rights reserved.
//

import UIKit



class NewItemCategoryCell: UITableViewCell {

    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var subCategoryLbl: UILabel!
    @IBOutlet weak var colorLbl: UILabel!
    
    var catObj: Category!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        colorLbl.hidden = true
        
    }

    
         
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
