//
//  TeamMemberTableViewController.swift
//  SEngage
//
//  Created by Yan Wu on 5/4/16.
//  Copyright © 2016 Avaya. All rights reserved.
//

import UIKit

class TeamMemberTableViewController: UITableViewController {

    // MARK: Properties
    var contacts = [Contact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Members"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("respondsToBarButtonItem:"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell  identifier.
        let cellIdentifier = "ContactsTableViewCell"
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ContactsTableViewCell
        
        // Fetches the appropriate contact for the data source layout.
        let contact = contacts[indexPath.row]
        
        cell.nameLabel.text = contact.name
        cell.photoImageView.image = contact.photo
        if contact.status == "idle" {
            cell.statusImageView.backgroundColor = UIColor.yellowColor()
        } else if contact.status == "available" {
            cell.statusImageView.backgroundColor = UIColor.greenColor()
        } else if contact.status == "busy" {
            cell.statusImageView.backgroundColor = UIColor.redColor()
        } else {
            cell.statusImageView.backgroundColor = UIColor.grayColor()
        }
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "show" {
            let contactDetailTableViewController = segue.destinationViewController as! ContactDetailTableViewController
            
            // Get the cell that generated this segue
            if let selectedContactCell = sender as? ContactsTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedContactCell)!
                let selectedContact = contacts[indexPath.row]
                contactDetailTableViewController.contact = selectedContact
            }
        }
    }
}
