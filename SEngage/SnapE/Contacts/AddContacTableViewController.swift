//
//  AddContacTableViewController.swift
//  SEngage
//
//  Created by Yan Wu on 4/20/16.
//  Copyright © 2016 Avaya. All rights reserved.
//

import UIKit

class AddContacTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        
//        // Table view cells are reused and should be dequeued using a cell  identifier.
//        let cellIdentifier = "SearchResultTableViewCell"
//        
//        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! SearchResultTableViewCell
//        
//        // Fetches the appropriate contact for the data source layout.
//        // let contact = contacts[indexPath.row]
//        
//        cell.nameLabel.text = contact.name
//        cell.phoneLabel.text = contact.phone
//        cell.emailLabel.text = contact.email
//        
//        return cell
//    }
}
