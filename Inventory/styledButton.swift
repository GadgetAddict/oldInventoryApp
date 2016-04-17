//
//  styledButton.swift
//  Inventory
//
//  Created by Michael King on 3/31/16.
//  Copyright © 2016 Michael King. All rights reserved.
//

import UIKit

class styledButton: UIButton {

    override func awakeFromNib() {
        layer.borderWidth = 1.0
         layer.borderColor = UIColor.whiteColor().CGColor
        layer.cornerRadius = 5.0
        layer.shadowColor = UIColor(red: SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 0.5).CGColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSizeMake(0.0, 2.0)
      
    }
}

 
extension UIColor
{
    convenience init(red: Int, green: Int, blue: Int)
    {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
}
 