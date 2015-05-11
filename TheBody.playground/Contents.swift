//: Playground - noun: a place where people can play

import UIKit


enum Bodytype : String {
    
    case Muscle1 = "Firm"
    case Muscle2 = "Soft"
    case Muscle3 = "Strong"
    case Muscle4 = "Weak"
    case Bone1 = "Short"
    case Bone2 = "Long"
}

enum Bodyform : String {
    
    case Skin1 = "Smooth"
    case Skin2 = "Rough"
}

class Core {
    
    var size: Int?
    var ripped: Bool = false
    
    
    
    init(structure: Bodytype) {
        
        size = structure.hashValue
        
    }
    
}

class Neck: Core {
    
    var veinColor: UIColor?
    var veins: Int?
    var bigNeck: Bool = true
    
   init(typeNeck: Bodytype) {
    
    }
    
    func stretchNeck(stretch: Bodyform) {
        println("I need to stretch my neck")
    }
    
    func workNeck(strenghten: Bodyform) {
        println("my neck is weak right now")
    }
    
    func rest(rest: Bodyform) {
        println("my muscles need rest")
    }
}

class Shoulder: Neck {
    
    var shoulderWidth: Int?
    var strongShoulder: Bool = true
    var flexibleShoulder: Bool = false
    
    init(typeShoulder: Bodytype ) {
        
    }
    
    func shoulderWorkout(work: Bodyform) {
        
        Neck(typeNeck: .Muscle3).workNeck(.Skin2)
        
    }
    
    func shoulderMassage(massage: Bodyform) {
        Neck(typeNeck: .Muscle1).rest(.Skin1)
    }
    
    func stretchShoulder(stretching: Bodyform) {
        Neck(typeNeck: .Muscle2).stretchNeck(.Skin1)
    }
    
    
    
}

var brolicShoulder = Shoulder(typeShoulder: .Muscle3)
brolicShoulder.veins = 7


class Biceps: Shoulder {
    
    var attachment = Shoulder(typeShoulder: .Muscle3)
    var firm: Bool = true
    var pullStrength: Int?
    
    init(typeBiceps: Bodytype) {
        
    }
    
}

class Triceps: Shoulder {
    
    var pushStrength: Int?
    var firm: Bool = true
    var contract = "extensor"
    

}

class Forearm: Biceps {
    
    var curl = Triceps(typeShoulder: .Muscle4)
    var stretch = "elongate"
    var sore = "Painful"
    
    init(typeForearm: Bodytype) {
        
    }
    
}

class Wrist: Shoulder {
    
    var flick = "flicka"
    var flex = "flexing"
    var heavy = "ice"
    
}

class Thumb: Shoulder {
    
    var sore = "hurt"
    var broken = "pains"
    var flexed = "stretchable"
    
}

class Indexfinger: Wrist {
    
    var wag = "mutumbo"
    var point = "disrespect"
    var sign = "number one"
    
}

class Leg: Core {
    
    var height = 5
    var density = "hard"
    var shape = "big"
    
}

class Quad: Leg {
    
    var twitch = "fast"
    var strength = Wrist(typeShoulder: .Muscle3)
    var width = 4
    
}

class Hamstring: Leg {
    
    var fiber = Leg(structure: .Muscle1)
    var cells = "smooth"
    var hammuscle = "explosive"
    
}

class Femur: Leg {
    
    var boneCell = Hamstring(structure: .Muscle3)
    var boneMarrow = "healthy"
    var boneDensity = Quad(structure: .Muscle1)
}

class Tibia: Core {
    
    var boneLength = Thumb(typeShoulder: .Bone2)
    var tibialdensity = Femur(structure: .Muscle1)
    var extensorMuscle = "extended"
    
}

class Knees: Leg {
    
    var kneeStrength = Tibia(structure: .Muscle4)
    var kneeStatus = Indexfinger(typeShoulder: .Muscle4)
    var playable = "gametime decision"
    
}

class Calf: Leg {
    
    var willPlay: Bool = true
    var soreCalf = Knees(structure: .Muscle4)
    var strongCalf = Forearm(typeForearm: .Muscle3)
    
}

class Ankle: Leg {

    var ankleHealthy = "good"
    var ankleSprain = "bad"
    var ankleRolled: Bool = false
    
}

class Head: Neck {
    
    
    
}

class Eyes: Head {
    
}

class Hair: Head {
    
}

class Mouth: Head {
    
}




















