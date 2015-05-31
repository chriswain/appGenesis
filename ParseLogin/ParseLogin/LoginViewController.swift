//
//  LoginViewController.swift
//  ParseLogin
//
//  Created by Christopher Wainwright Aaron on 5/28/15.
//  Copyright (c) 2015 Christopher Wainwright Aaron. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var loginUsernameField: UITextField!
    @IBOutlet weak var loginPasswordField: UITextField!
    
    @IBAction func loginButton(sender: UIButton) {
        
        PFUser.logInWithUsernameInBackground(loginUsernameField.text, password: loginPasswordField.text) { (user: PFUser?, error: NSError?) -> Void in
            
            if user != nil {
                
            } else {
                             }
           
            
        }
        
        println(PFUser.currentUser()?.username)
        
        if let logoutVC = storyboard?.instantiateViewControllerWithIdentifier("logoutVC") as? LogoutViewController {
            navigationController?.viewControllers = [logoutVC]
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
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
