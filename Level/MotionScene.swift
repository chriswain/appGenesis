//
//  MotionScene.swift
//  Level
//
//  Created by Christopher Wainwright Aaron on 6/29/15.
//  Copyright (c) 2015 Christopher Wainwright Aaron. All rights reserved.
//

import UIKit

import SpriteKit

class MotionScene: SKScene {
    
    override func didMoveToView(view: SKView) {
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        size = view.frame.size
        
        let dot = SKShapeNode(circleOfRadius: 10)
        
        dot.fillColor = UIColor.whiteColor()
        dot.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        
        dot.position = view.center
        
        physicsBody = SKPhysicsBody(edgeLoopFromRect: view.bounds)

        
        addChild(dot)

    }
}
