//
//  ViewController.swift
//  CalculatorFunctions
//
//  Created by Christopher Wainwright Aaron on 5/5/15.
//  Copyright (c) 2015 Chris Aaron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var firstNumber = ""
    var secondNumber = ""
    var currentOperation = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pressedButton1(sender: UIButton) {
        
        let number = sender.currentTitle!
        
        if currentOperation.isEmpty {
            
            firstNumber += number
            
        } else {
            
            secondNumber += number
        }
        
        
     
    }
    
    @IBAction func operatorPressed(sender: UIButton)
    {
        
        let operation = sender.currentTitle!
        
        if operation != "=" {
            
            currentOperation = operation
            
        } else {
            
            switch currentOperation {
                
            case "+":
                
                let value = firstNumber.toInt()! + secondNumber.toInt()!
                println("\(firstNumber) \(currentOperation) \(secondNumber) = \(value)")
                
            case "-":
                println("do subtraction")
            default :
                println("blah")
            }
        
            
            firstNumber = ""
            secondNumber = ""
            currentOperation = ""
            
        }
        
    }
    
    
    
}

