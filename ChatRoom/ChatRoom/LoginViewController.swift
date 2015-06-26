//
//  LoginViewController.swift
//  ChatRoom
//
//  Created by Whitney Hogg on 6/26/15.
//  Copyright (c) 2015 Christopher Aaron. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var loginUsername: UITextField!
    @IBOutlet weak var passwordLogin: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButton(sender: AnyObject) {
        
    }
    
    func loginUser() {
        
        let username = loginUsername.text
        let password = passwordLogin.text
        
        PFUser.logInWithUsernameInBackground(username, password: password) { (user: PFUser?, error: NSError?) -> Void in
            
            if user != nil {
                let chatRoomVC = self.storyboard?.instantiateInitialViewController() as! ChatRoomViewController
                self.navigationController?.popToViewController(chatRoomVC, animated: true)
            } else {
                println("\(error)")
            }
        }
    }


}
