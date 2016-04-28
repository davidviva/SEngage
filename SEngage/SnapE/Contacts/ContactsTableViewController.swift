//
//  ContactsTableViewController.swift
//  SEngage
//
//  Created by Yan Wu on 3/23/16.
//  Copyright © 2016 Avaya. All rights reserved.
//

import UIKit

class ContactsTableViewController: UITableViewController {
    
    let contactIndexTitleList:[String] = [
        "A", "B", "C", "D", "E", "F", "G",
        "H", "I", "J", "K", "L", "M", "N",
        "O", "P", "Q", "R", "S", "T",
        "U", "V", "W", "X", "Y", "Z"]
    
    // MARK: Properties
    var contacts = [Contact]()
    var segmentedControl:UISegmentedControl!
    var teamView: TeamView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contacts = GenerateData.generateContacts(10)
        contacts.sortInPlace({$0.name < $1.name})
        
        //navigationItem.leftBarButtonItem = editButtonItem()
        segmentedSetting()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func segmentedSetting() {
        teamView = TeamView()
        segmentedControl = UISegmentedControl(items: ["Contacts","Teams"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.center=self.view.center
        segmentedControl.addTarget(self, action: #selector(ContactsTableViewController.segmentedControlAction(_:)), forControlEvents: .ValueChanged)
        self.navigationItem.titleView = segmentedControl
    }
    
    func segmentedControlAction(sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            self.view.hidden = false
            teamView.hidden = true
        case 1:
            self.view.hidden = true
            teamView.hidden = false
        default:
            break;
        }
    }
    
    // MARK: - Table view data source
    
    // set the number of sections
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
//    // set titles for each section
//    override func tableView(tableView:UITableView, titleForHeaderInSection section:Int)->String {
//        var headers = self.contactIndexTitleList;
//        return headers[section];
//    }
    
    // set rows in section
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell  identifier.
        let cellIdentifier = "ContactsTableViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ContactsTableViewCell
        
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
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell,
                   forRowAtIndexPath indexPath: NSIndexPath){
        //设置cell的显示动画为3D缩放
        //xy方向缩放的初始值为0.1
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        //设置动画时间为0.25秒，xy方向缩放的最终值为1
        UIView.animateWithDuration(0.25, animations: {
            cell.layer.transform=CATransform3DMakeScale(1, 1, 1)
        })
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            let contactDetailTableViewController = segue.destinationViewController as! ContactDetailTableViewController
            
            // Get the cell that generated this segue
            if let selectedContactCell = sender as? ContactsTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedContactCell)!
                let selectedContact = contacts[indexPath.row]
                contactDetailTableViewController.contact = selectedContact
            }
        }
        else if segue.identifier == "addContact" {
            print("Adding new contact.")
        }
    }
    
//    //right side index bar: "A" ... "Z"
//    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
//        return contactIndexTitleList
//    }
//    
//    override func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
//        var tpIndex:Int = 0
//        // traverse the value of indexes
//        for character in contactIndexTitleList{
//            // if the index equals the tile, return the value
//            if character == title{
//                return tpIndex
//            }
//            tpIndex += 1
//        }
//        return 0
//    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            contacts.removeAtIndex(indexPath.row)
            
            // need to save the new contacts array in the db
            save()
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    func save() {
        
    }
}
