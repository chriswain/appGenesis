//
//  ChatRoomViewController.swift
//  ChatRoom
//
//  Created by Christopher Wainwright Aaron on 6/29/15.
//  Copyright (c) 2015 Christopher Aaron. All rights reserved.
//

import UIKit
import Parse

class ChatRoomViewController: UIViewController {

    
    @IBOutlet weak var enterMessageField: UITextField!
    
    @IBOutlet weak var chatFeed: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var currentUser = PFUser.currentUser()
        if currentUser != nil {
        
            println("User logged in")
        } else {
            
            let evc = storyboard?.instantiateViewControllerWithIdentifier("entryVC") as! EntryViewController
            presentViewController(evc, animated: true, completion: nil)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutButton(sender: AnyObject) {
        
        PFUser.logOut()
        var currentUser = PFUser.currentUser() // this will now be nil
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
