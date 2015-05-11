//
//  ViewController.swift
//  TicTacToe
//
//  Created by Christopher Wainwright Aaron on 5/8/15.
//  Copyright (c) 2015 Chris Aaron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       let location5 = CGPointMake(100, 100)
        
        var ticTacCircle = TicTacCircle()
        view.addSubview(ticTacCircle)
        ticTacCircle.center = location5
    
        
    }

    @IBAction func ticButtion(sender: UIButton) {
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

