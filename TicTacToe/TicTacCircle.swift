//
//  TicTacCircle.swift
//  TicTacToe
//
//  Created by Christopher Wainwright Aaron on 5/8/15.
//  Copyright (c) 2015 Chris Aaron. All rights reserved.
//

import UIKit

class TicTacCircle: UIView {

    override func didMoveToWindow() {
        
        backgroundColor = UIColor.whiteColor()
        layer.borderColor = UIColor.blueColor().CGColor
        layer.borderWidth = 4
        
        frame.size.height = 100
        frame.size.width = 100
        
        layer.cornerRadius = frame.size.width / 2
        
        
    }
    

}
