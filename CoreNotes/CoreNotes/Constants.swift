//
//  Constants.swift
//  CoreNotes
//
//  Created by Whitney Hogg on 6/23/15.
//  Copyright (c) 2015 Christopher Aaron. All rights reserved.
//

import UIKit
// 2
// create a function that returns a UIColor based on a string

let DEBUG = true 

let categories: [String:(String, UIColor)] = [
    
    "Red" : ("Lava", UIColor.redColor()),
    "Blue" : ("Sky", UIColor.cyanColor()),
    "Yellow" : ("Lazy", UIColor.yellowColor()),
    "Purple" : ("Unicorn", UIColor.purpleColor()),
    "Orange" : ("Fruit", UIColor.orangeColor())


]

func categoryColor(name: String) -> UIColor {
    
    return categories[name]!.1
}
//var arrayOfColors = ["green","blue","cyan","gray","red"]
//
//var arrayName = ["Completed","Pending","Casual","Low","Urgent"]
//
//func categoryInfo(index: Int) -> (String,String) {
//   
//    return (arrayOfColors[index], arrayName[index])
//}
//
//var colors = [
//    "green" : UIColor.greenColor(),
//    "blue" : UIColor.blueColor(),
//    "cyan" : UIColor.cyanColor(),
//    "gray" : UIColor.grayColor(),
//    "red" : UIColor.redColor()
//]
//
//func colorFromString(color: String) -> UIColor {
//    
//    return colors[color]!
//}
