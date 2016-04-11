//
//  WineCell.swift
//  Inventory
//
//  Created by Michael King on 4/3/16.
//  Copyright © 2016 Michael King. All rights reserved.
//

import Cosmos
import UIKit
import Firebase

class WineCell: UITableViewCell {

    var wine: Wine!
    
    @IBOutlet weak var wineNameLbl: UILabel!
    @IBOutlet weak var wineMakerLbl: UILabel!
    
    @IBOutlet weak var starsLbl: CosmosView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func configureCell(wine: Wine) {
     self.wine = wine
    
        self.wineNameLbl.text = wine.wineName
        self.wineMakerLbl.text = wine.wineVintner
        self.starsLbl.rating = wine.wineRating!
    }
}
