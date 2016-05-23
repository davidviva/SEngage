//
//  TeamCreationViewController.swift
//  SEngage
//
//  Created by Yan Wu on 5/20/16.
//  Copyright © 2016 Avaya. All rights reserved.
//

import UIKit

class TeamCreationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    // MARK: Properties
    var group: Group?
    var contacts = [Contact]()
    var groupContacts = [Contact]()
    var selectedData = [Int]()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Team Creation"
        
        loadContacts()
        initTextField()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func loadContacts() {
        contacts = GenerateData.generateContacts(10)
        contacts.sortInPlace({$0.name < $1.name})
    }
    
    func initTextField() {
        self.textField.delegate = self
        self.textField.layer.cornerRadius = 10
        self.textField.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.textField.layer.borderWidth = 0.5
        self.textField.placeholder = "Please input the group name"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // set the number of sections
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    // set rows in section
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
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
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedData.append(indexPath.row)
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let index = self.selectedData.indexOf(indexPath.row)
        self.selectedData.removeAtIndex(index!)
    }
    
    @IBAction func selectAction(sender: UIBarButtonItem) {
        group = Group(name: self.textField.text!, photo: UIImage(asset:.Contacts_add_newmessage), contacts: groupContacts)
        for index in selectedData {
            let contact = contacts[index]
            group!.contacts.append(contact)
        }
        saveGroup()
        navigationController!.popViewControllerAnimated(true)
    }
    
    // Save the change into db
    func saveGroup() {
        
    }


}
