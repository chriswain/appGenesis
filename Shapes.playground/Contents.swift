//: Playground - noun: a place where people can play

import UIKit

enum ShapeType: Int {
   
    case Triangle = 3
    case Rectangle = 4
    case Pentagon = 5
    case Hexagon = 6
    case Septagon = 7
    case Octagon = 8
    
}

class Shape {
    
    var sides: Int?
    
    var fillColor: UIColor?
    var strokeColor: UIColor?
    
    init(type: ShapeType) {
        
        sides = type.rawValue
        
    }
    

    
}

var square1 = Shape(type: ShapeType.Rectangle)

var squarepixels = 4 * square1.sides!

var triangle1 = Shape(type: ShapeType.Triangle)

var trianglepixels = 4 * triangle1.sides!


class Mouth {
    
    var lipsColor: UIColor!
    var teethCount: Int!
    
    var badBreath: Bool = false
    var fullOfFood: Bool = false
    
    init(teeth: Int, lips: UIColor) {
        
        teethCount = teeth
        lipsColor = lips
    }
    


func chewFood(food: AnyObject) {
    
    println("eating")
    
}

func yawn() {
    
}

}

























