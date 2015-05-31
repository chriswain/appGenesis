//
//  LogoutViewController.swift
//  ParseLogin
//
//  Created by Christopher Wainwright Aaron on 5/28/15.
//  Copyright (c) 2015 Christopher Wainwright Aaron. All rights reserved.
//

import UIKit
import Parse

class LogoutViewController: UIViewController {
    
    
    @IBOutlet weak var usernameLabel: UILabel!
   
    @IBOutlet weak var emailLabel: UILabel!

    @IBAction func logoutButton(sender: UIButton) {
        
        if let startVC = storyboard?.instantiateViewControllerWithIdentifier("startVC") as? StartViewController {
            navigationController?.viewControllers = [startVC]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameLabel.text = PFUser().username
        emailLabel.text = PFUser().email
        
        

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
