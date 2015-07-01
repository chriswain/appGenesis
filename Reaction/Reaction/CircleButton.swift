//
//  CircleButton.swift
//  Reaction
//
//  Created by Christopher Wainwright Aaron on 7/1/15.
//  Copyright (c) 2015 Christopher Wainwright Aaron. All rights reserved.
//

import UIKit

@IBDesignable class CircleButton: UIButton {
    
    var choice: Int!
   
    @IBInspectable var fillColor: UIColor = UIColor.whiteColor()
    
    override func drawRect(rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        
        fillColor.set()
        
        CGContextFillEllipseInRect(context, rect)
    }
}
