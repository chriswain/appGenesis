//
//  ViewController.swift
//  FromScratch
//
//  Created by Christopher Wainwright Aaron on 5/7/15.
//  Copyright (c) 2015 Chris Aaron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
    }

    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        for touch in touches as! Set<UITouch> {
            
            let location = touch.locationInView(view)
            
            println("x = \(location.x) and y = \(location.y)")
           
            var box = CocoDubs()
            view.addSubview(box)
            box.center = location
            
            
        }
    
    }


}

// Normal Mode

// Make box a circle
// randomize he circle size (width will be same as height)
// randomize the color of the circle
// Randomize the alpha of the circle

//Middle Mode

// Transition to alpha 0 after 1 second (UIView animation)

// Hard Mode

// Randomize rotation of box
// Randomize whether it is round or not
// randomize between full circle -> rounded square -> square
