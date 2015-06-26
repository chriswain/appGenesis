//
//  SignUpViewController.swift
//  ChatRoom
//
//  Created by Whitney Hogg on 6/26/15.
//  Copyright (c) 2015 Christopher Aaron. All rights reserved.
//

import UIKit
import Parse
class SignUpViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUpButton(sender: AnyObject) {
        userSignUp()
    }
    
    
    func userSignUp() {
        
        let user = PFUser()
        user.username = usernameTextField.text
        user.password = passwordTextField.text
        user.email = emailTextField.text
        
        user.signUpInBackgroundWithBlock { (succeeded: Bool, error: NSError?) -> Void in
            
            if let error = error {
                let errorString = error.userInfo?["error"] as? String
                println("\(errorString)")
            } else {
                let chatRoomVC = self.storyboard?.instantiateInitialViewController() as! ChatRoomViewController
                self.navigationController?.popToViewController(chatRoomVC, animated: true)
            }
        }
        
    }
    

}
