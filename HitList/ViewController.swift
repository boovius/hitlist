//
//  ViewController.swift
//  HitList
//
//  Created by Joshua Book on 6/9/15.
//  Copyright (c) 2015 Boovius Projects. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {
    let managedContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
    
    @IBOutlet weak var tableView: UITableView!
    var activities = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Get Shit Done"
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let fetchRequest = NSFetchRequest(entityName: "Activity")
        
        var error: NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: (&error)) as? [NSManagedObject]
        
        if let results = fetchedResults {
            activities = results
        } else {
            println("Could not fetch results from core data \(error), \(error!.userInfo)")
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("activityCell", forIndexPath: indexPath) as! ActivityCell

        let activity = activities[indexPath.row] as! Activity

        cell.activityTitle.text = activity.activity

        cell.count.text = "\(activity.count)"
        
        cell.doButton.tag = indexPath.row
        
        cell.doButton.addTarget(self, action: "doActivity:", forControlEvents: .TouchUpInside)
        return cell
        
    }
    
    @IBAction func doActivity(sender: UIButton) {
        let activity = activities[sender.tag] as! Activity
        
        var num = activity.count as IntegerLiteralType
        num = num + 1
        activity.count = num as NSNumber
        
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        } else {
            self.tableView.reloadData()
        }
    }

    @IBAction func addName(sender: AnyObject) {
        var alert = UIAlertController(
            title: "New activity",
            message: "Add a new activity",
            preferredStyle: .Alert
        )
        
        let saveAction = UIAlertAction(
            title: "Save",
            style: UIAlertActionStyle.Default,
            handler: {(action: UIAlertAction!) -> Void in
            
            let textField = alert.textFields![0] as! UITextField
            self.saveActivity(textField.text)
            self.tableView.reloadData()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default) { (action: UIAlertAction!) -> Void in }
        
        alert.addTextFieldWithConfigurationHandler { (textField: UITextField!) -> Void in }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func saveActivity(name: NSString) {
        
        let entity = NSEntityDescription.entityForName("Activity", inManagedObjectContext: managedContext)
        
        let activity = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        activity.setValue(name, forKey: "activity")
        
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
        
        activities.append(activity)
    }

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let activity = activities[indexPath.row] as! Activity
        managedContext.deleteObject(activity)
        activities.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        self.tableView.reloadData()
    }
}

