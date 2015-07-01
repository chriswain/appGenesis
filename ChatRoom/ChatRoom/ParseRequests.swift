//
//  ParseRequests.swift
//  ChatRoom
//
//  Created by Christopher Wainwright Aaron on 6/30/15.
//  Copyright (c) 2015 Christopher Aaron. All rights reserved.
//

import UIKit
import Parse

private let defaults = NSUserDefaults.standardUserDefaults()
private let _singleton = ParseRequest()

class ParseRequest: NSObject {
    
    class func session() -> ParseRequest { return _singleton }
    
    let API_URL = ""
    
    var currentUser: String? {
        
        get {
            return defaults.objectForKey("currentUser") as? String
        }
        
        set {
            
            defaults.setValue(newValue, forKey: "currentUser")
            defaults.synchronize()
        }
    }
    
    func requestWithInfo( info: [String:AnyObject], andCompletion completion: ((responseInfo: [String:AnyObject]?) -> Void)?) {
        
        let endpoint = info["endpoint"] as! String
        
        if let url = NSURL(string: API_URL + endpoint) {
            
            let request = NSMutableURLRequest(URL: url)
            
            request.HTTPMethod = info["method"] as! String
            
            if let currentUser = currentUser {
                
                request.setValue(currentUser, forHTTPHeaderField: "Authorization")
            }
            
            //// Body
            
            if let bodyInfo = info["parameters"] as? [String:AnyObject] {
                
                println(bodyInfo)
                
                if let requestData = NSJSONSerialization.dataWithJSONObject(bodyInfo, options: NSJSONWritingOptions.allZeros, error: nil) {
                    
                    if let jsonString = NSString(data: requestData, encoding: NSUTF8StringEncoding) {
                        
                        let postLength = "\(jsonString.length)"
                        request.setValue(postLength, forHTTPHeaderField: "Content-Length")
                        
                        let postData = jsonString.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true)
                        
                        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                        request.HTTPBody = postData
                        
                        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response, data, error) -> Void in
                            
                            println(data)
                            
                            if let data = data {
                                
                                if let json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil) as? [String:AnyObject] {
                                    
                                    println(json)
                                    
                                    completion?(responseInfo: json)
                                }
                            }
                        })
                    }
                }
            }
        }
    }
    
}