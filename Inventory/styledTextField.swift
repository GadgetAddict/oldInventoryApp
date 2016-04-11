//
//  StyledTextField.swift
//  Inventory
//
//  Created by Michael King on 4/6/16.
//  Copyright © 2016 Michael King. All rights reserved.
//

import UIKit

class styledTextField: UITextField {
    
    override func awakeFromNib() {
        layer.cornerRadius = 3.0
        layer.borderColor = UIColor(red: SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 0.8).CGColor
        
        layer.borderWidth = 0.6
    }
    // For Placeholder
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 10, 0 )
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 10,0 )
    }
    
    
}


