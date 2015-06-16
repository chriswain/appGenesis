//
//  ViewController.swift
//  roo
//
//  Created by Christopher Wainwright Aaron on 6/15/15.
//  Copyright (c) 2015 Christopher Wainwright Aaron. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var myName: String?
    
    var chatMessages: [String:[String:AnyObject]] = [:]
    
    @IBOutlet weak var messageButton: UIButton!
    
    @IBOutlet weak var chatField: UITextField!
    
    @IBOutlet weak var nameButton: UIButton!
    
    
    @IBOutlet weak var messagesTableView: UITableView!
    
    var myFireBase = Firebase(url:"https://secret-roomBA.firebaseio.com")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Read data and react to changes
        myFireBase.observeEventType(.Value, withBlock: {
            snapshot in
            
            if let data = snapshot.value as? [String:AnyObject] {
                
                self.chatMessages = data["messages"] as! [String:[String:AnyObject]]
                
                self.messagesTableView.reloadData()
            }
        })
        messagesTableView.dataSource = self
        messagesTableView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveName(sender: UIButton) {
        
        myName = chatField.text
        
        nameButton.hidden = true
        messageButton.hidden = false
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessages.values.array.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("messageCell") as! UITableViewCell
        
        let message = chatMessages.values.array[indexPath.row]
        
        cell.textLabel?.text = message["name"] as? String
        cell.textLabel?.text = message["message"] as? String
        
        return cell
        
    }
    
    
    @IBAction func sendMessage(sender: UIButton) {
        
        let fireBaseMessages = myFireBase.childByAppendingPath("messages")
        
        let fireBaseMessage = fireBaseMessages.childByAutoId()
        
        let message = [
            
            "message" : chatField.text,
            "name" : myName
        ]
        
        fireBaseMessage.setValue(message)
        
    }
    
}

