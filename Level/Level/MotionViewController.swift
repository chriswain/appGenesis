//
//  MotionViewController.swift
//  Level
//
//  Created by Christopher Wainwright Aaron on 6/29/15.
//  Copyright © 2015 Christopher Wainwright Aaron. All rights reserved.
//

import UIKit
import CoreMotion
import SpriteKit

class MotionViewController: UIViewController {
    
    let manager = CMMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var motionScene = MotionScene()
        let sceneView = SKView(frame: view.frame)
        view.addSubview(sceneView)
        
        sceneView.presentScene(motionScene)
        
        manager.startDeviceMotionUpdatesToQueue(NSOperationQueue.currentQueue()) { (deviceMotion, error) -> Void in
            
            // motionScene.physicsWorld.gravity = CGVector(dx: deviceMotion.rotationRate.y * 10, dy: -deviceMotion.rotationRate.x * 10)
           // println(RadiansToDegrees(deviceMotion.attitude.yaw))
            
            let quat = deviceMotion.attitude.quaternion;
            let myRoll = RadiansToDegrees(atan2(2*(quat.y*quat.w - quat.x*quat.z), 1 - 2*quat.y*quat.y - 2*quat.z*quat.z))
            let myPitch = RadiansToDegrees(atan2(2*(quat.x*quat.w + quat.y*quat.z), 1 - 2*quat.x*quat.x - 2*quat.z*quat.z))
            let myYaw = RadiansToDegrees(asin(2*quat.x*quat.y + 2*quat.w*quat.z))
            
            println("\(RadiansToDegrees(deviceMotion.attitude.yaw)) \(myYaw)")
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                motionScene.physicsWorld.gravity = CGVector(dx: myYaw / 8, dy: -8.0)
                
            })
            
            
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

func RadiansToDegrees (value:Double) -> Double {
    return value * 180.0 / M_PI
}

