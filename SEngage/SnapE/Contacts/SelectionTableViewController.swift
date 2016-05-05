//
//  SelectionTableViewController.swift
//  SEngage
//
//  Created by Yan Wu on 5/5/16.
//  Copyright © 2016 Avaya. All rights reserved.
//

import UIKit

class SelectionTableViewController: UITableViewController {

    // MARK: Properties
    var contacts = [Contact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsMultipleSelection = true
        
        contacts = GenerateData.generateContacts(10)
        contacts.sortInPlace({$0.name < $1.name})
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    // set the number of sections
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    // set rows in section
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell  identifier.
        let cellIdentifier = "ContactsTableViewCell"
            
        let cell = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ContactsTableViewCell
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        // Fetches the appropriate contact for the data source layout.
        let contact = contacts[indexPath.row]
            
        cell.nameLabel.text = contact.name
        cell.photoImageView.image = contact.photo
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
}
