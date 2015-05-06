//
//  ViewController.swift
//  SimpleButtons
//
//  Created by Christopher Wainwright Aaron on 5/4/15.
//  Copyright (c) 2015 Chris Aaron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var showValue: UILabel!
    
    var firstNumber = ""
    var secondNumber = ""
    var currentOperation = ""
    var clear = ""
    let percentCalc: Double = 0.01
    let decimal = "."
    let negative = -1
    
    
    @IBAction func clearButton(sender: UIButton) {

            firstNumber = clear
            showValue.text = "\(firstNumber)"
        
    }
   
    @IBAction func clearButtontwo(sender: UIButton) {
        
        secondNumber = clear
        showValue.text = "\(secondNumber)"
    }
    
    @IBAction func clearButtonOp(sender: UIButton) {
        
        currentOperation = clear
    }
    
        
  //   @IBAction func pressedDecimal(sender: UIButton) {
       
  //      firstNumber += decimal
        
  //  }
    
  //  @IBAction func pressedDecimaltwo(sender: UIButton) {
        
  //      secondNumber += decimal
  //  }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonPressed(sender: UIButton) {
        
        let number = sender.currentTitle!
        
        if currentOperation.isEmpty {
            
            firstNumber += number
            showValue.text = "\(firstNumber)"
        } else {
            
            secondNumber += number
            showValue.text = "\(secondNumber)"
            
        }
        
    }
    
    
    @IBAction func percentButton(sender: UIButton) {
        let value = Double(firstNumber.toInt()!) * percentCalc
        println("\(value)")
        showValue.text = "\(value)"
        
    }
    
//    @IBAction func changeSign(sender: UIButton) {
//        
//        let value = (firstNumber.toInt()!) * negative
//        println("\(value)")
//        showValue.text = "\(value)"
//    }
    
    
    @IBAction func operationPressed(sender: UIButton) {
        
        let operation = sender.currentTitle!
        
        if operation != "=" {
            
            currentOperation = operation
            
        } else {
            
            switch currentOperation {
                
                case "+":
                
                let value = firstNumber.toInt()! + secondNumber.toInt()!
                println("\(firstNumber) \(currentOperation) \(secondNumber) = \(value)")
                showValue.text = "\(value)"
                
                case "-":
                
                let value = firstNumber.toInt()! - secondNumber.toInt()!
                println("\(firstNumber) \(currentOperation) \(secondNumber) = \(value)")
                showValue.text = "\(value)"
                
                case "÷":
                
                let value = Double(firstNumber.toInt()!) / Double(secondNumber.toInt()!)
                println("\(firstNumber) \(currentOperation) \(secondNumber) = \(value)")
                showValue.text = "\(value)"
                
                case "X":
                
                let value = Double(firstNumber.toInt()!) * Double(secondNumber.toInt()!)
                println("\(firstNumber) \(currentOperation) \(secondNumber) = \(value)")
                showValue.text = "\(value)"
                
//                case "%":
//                
//                let value = Double(firstNumber.toInt()!) * 0.01
//                println("\(firstNumber) \(currentOperation) \(secondNumber) = \(value)")
//                showValue.text = "\(value)"
                
                default:
                println("Nada")
            }
            
            firstNumber = ""
            secondNumber = ""
            currentOperation = ""
    
            
            
        }
        
        
        
    }
    
    
    

}













