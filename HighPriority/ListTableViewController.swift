//
//  ListTableViewController.swift
//  HighPriority
//
//  Created by Christopher Wainwright Aaron on 5/11/15.
//  Copyright (c) 2015 Chris Aaron. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {

    // [String]
    // [String:String]
    
    enum Priority {
        case High
        case Medium
        case Low
    }
    
    @IBOutlet weak var highPriorityButton: PButton!
    
    @IBOutlet weak var medPriorityButton: PButton!
    
    @IBOutlet weak var lowPriorityButton: PButton!
    
    @IBAction func highPriorityClick(sender: PButton) {
        pNumber = 0
    }
    
    @IBAction func medPriorityClick(sender: PButton) {
        pNumber = 1
    }
    
    @IBAction func lowPriorityClick(sender: PButton) {
        pNumber = 2
    }
    
    

   
    var pNumber: Int = 0
    var listItems: [[String:AnyObject]] = [
        
        [
            "name" : "Sleep",
            "timeCreated" : NSDate(),
            "priority" : 0,
            "completed" : false
        ],
        
        [
            
            "name" : "Get Food",
            "timeCreated" : NSDate(),
            "priority" : 2,
            "completed" : false
        ]
    
    ]
  
    @IBOutlet weak var itemNameField: UITextField!
    
    func clearText() {
        itemNameField.editing.boolValue
        itemNameField.clearsOnBeginEditing.boolValue
    } // this sucks :(
   
    @IBAction func createItem(sender: AnyObject) {
        
        var itemInfo = [
            "name" : itemNameField.text,
            "timeCreated" : NSDate(),
            "priority" : pNumber,
            "completed" : false
        ]
        
        
        
        listItems.insert(itemInfo, atIndex: 0)
        clearText()
        //     itemNameField.delegate?.textFieldShouldClear!(itemNameField)
        
        tableView.reloadData()
    }
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
        
//        highPriorityButton.layer.cornerRadius = highPriorityButton.bounds.size.width / 2

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Potentially incomplete method implementation.
//        // Return the number of sections.
//        return 0
//    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return listItems.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("listCell", forIndexPath: indexPath) as! ListTableViewCell

        cell.itemInfo = listItems[indexPath.row]
        // Configure the cell...
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            listItems.removeAtIndex(pNumber)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
