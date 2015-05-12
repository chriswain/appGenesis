//
//  PButton.swift
//  HighPriority
//
//  Created by Christopher Wainwright Aaron on 5/11/15.
//  Copyright (c) 2015 Chris Aaron. All rights reserved.
//

import UIKit

//enum Priority {
//    
//    case High
//    case Medium
//    case Low
//    
//}


@IBDesignable class PButton: UIButton {
    
    @IBInspectable var priorityB: Int = 0
    
    override func drawRect(rect: CGRect) {
        
        
        var context = UIGraphicsGetCurrentContext()
        var smallCircleRect = CGRectInset(rect, 0, 0)
        var insetRect = CGRectInset(rect, 1, 1)
        
        priorityColors[priorityB].set()

        
        CGContextFillEllipseInRect(context, smallCircleRect)
        
//        layer.borderColor = UIColor.blackColor() as! CGColor
//        layer.borderWidth = 2
        

//        if touchInside {
//            CGContextStrokeEllipseInRect(context, insetRect)
//            
//            UIView.animateWithDuration(3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {self.alpha = 0.0}) { (Bool) -> Void in}
//        }
    }
    
}
