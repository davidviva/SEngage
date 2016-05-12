//
//  TeamDetailTableViewController.swift
//  SEngage
//
//  Created by Yan Wu on 5/4/16.
//  Copyright © 2016 Avaya. All rights reserved.
//

import UIKit

class TeamDetailTableViewController: UITableViewController {

    var group: Group?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Team Detail"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMembers" {
            let teamMemberTableViewController = segue.destinationViewController as! TeamMemberTableViewController
            
            let selectedContacts = group?.contacts
            teamMemberTableViewController.contacts = selectedContacts!
        }
        else if segue.identifier == "addMember" {
            let selectionTableViewController = segue.destinationViewController as! SelectionTableViewController
            selectionTableViewController.group = group
        }
    }

}
