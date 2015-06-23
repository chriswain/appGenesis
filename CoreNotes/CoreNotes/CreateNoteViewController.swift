//
//  CreateNoteViewController.swift
//  CoreNotes
//
//  Created by Whitney Hogg on 6/23/15.
//  Copyright (c) 2015 Christopher Aaron. All rights reserved.
//

import UIKit
import CoreData
// 3
// add a category relationship for the new note

// hard mode
// add a textfield and button that takes value of text field as a tag and everytime you hit button that adds to a bigger field with comma seperated
// add tags comma seperated  for the new note

var appDelegate: AppDelegate = {
    
    return UIApplication.sharedApplication().delegate as! AppDelegate
}()

//var moc: NSManagedObjectContext? = {
//
//    return (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
//}()

class CreateNoteViewController: UIViewController {

    @IBOutlet weak var createTextField: UITextField!
   
    
    @IBAction func createNote(sender: UIButton) {
        
        if let moc = appDelegate.managedObjectContext {
            var newObject = NSEntityDescription.insertNewObjectForEntityForName("Note", inManagedObjectContext: moc) as! NSManagedObject
            
            newObject.setValue(createTextField.text, forKey: "content")
            newObject.setValue(NSDate(), forKey: "date")
            
            appDelegate.saveContext()
            
            dismissViewControllerAnimated(true, completion: nil)
        }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
