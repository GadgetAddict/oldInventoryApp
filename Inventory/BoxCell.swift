//
//  BoxCell
//  Inventory
//
//  Created by Michael King on 4/3/16.
//  Copyright © 2016 Michael King. All rights reserved.
//


import UIKit
import Firebase

class BoxCell: UITableViewCell {
    
    var box: Box!
    
    @IBOutlet weak var fragileImg: UIImageView!
    @IBOutlet weak var boxNumberLbl: UILabel!
    @IBOutlet weak var boxCatLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        fragileImg.hidden = true
    
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell(box: Box) {
        self.box = box
        self.boxNumberLbl.text = ("\(box.boxNumber)")
       self.boxCatLbl.text = box.boxCategory!
    }
    
    
}
