//
//  CocoDubs.swift
//  FromScratch
//
//  Created by Christopher Wainwright Aaron on 5/7/15.
//  Copyright (c) 2015 Chris Aaron. All rights reserved.
//

import UIKit

class CocoDubs: UIView {

    override func didMoveToWindow() {
       
        
        var randomNum = CGFloat(arc4random_uniform(100))
        var randomColorR = CGFloat(arc4random_uniform(255)) / 255
        var randomColorG = CGFloat(arc4random_uniform(255)) / 255
        var randomColorB = CGFloat(arc4random_uniform(255)) / 255
        var randomAlpha = CGFloat(Double(arc4random()) / Double(UInt32.max))
        var randomInt = CGFloat(arc4random_uniform(100))
        
        println(randomNum)
        
        backgroundColor = UIColor(red: randomColorR, green: randomColorG, blue: randomColorB, alpha: randomAlpha)
       
        frame.size.width = randomNum
        frame.size.height = randomNum
   
        layer.cornerRadius = frame.size.height / randomInt
        
        UIView.animateWithDuration(1, delay: 2, options: UIViewAnimationOptions.CurveEaseInOut, animations: {self.alpha = 0.0}) { (Bool) -> Void in}
        
        transform = CGAffineTransformMakeRotation(CGFloat(randomInt))
        
        }


}
