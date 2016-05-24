//
//  ContactsViewController.swift
//  SEngage
//
//  Created by Yan Wu on 3/23/16.
//  Copyright © 2016 Avaya. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate {
    
    let contactIndexTitleList:[String] = [
        "A", "B", "C", "D", "E", "F", "G",
        "H", "I", "J", "K", "L", "M", "N",
        "O", "P", "Q", "R", "S", "T",
        "U", "V", "W", "X", "Y", "Z"]
    
    // MARK: Properties
    var contacts = [Contact]()
    var teams = [Group]()
    // search results DataSource
    var resultContacts = [Contact]()
    var resultTeams = [Group]()
    var segment = 0
    var segmentedControl:UISegmentedControl!
    var actionFloatView: ActionFloatView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contacts = GenerateData.generateContacts(10)
        contacts.sortInPlace({$0.name < $1.name})
        self.resultContacts = self.contacts
        
        teams = GenerateData.generateTeams(15)
        teams.sortInPlace({$0.name < $1.name})
        self.resultTeams = self.teams
        
        //navigationItem.leftBarButtonItem = editButtonItem()
        segmentedSetting()
        self.searchBar.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        initNavigationBarItem()
        initActionFloatView()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.actionFloatView.hide(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initNavigationBarItem() {
        let button: UIButton = UIButton(type: UIButtonType.Custom)
        //        button.setImage(UIImage(asset:.Barbuttonicon_add), forState: .Normal)
        button.setTitle("➕", forState: .Normal)
        button.frame = CGRectMake(0, 0, 40, 30)
        button.imageView!.contentMode = .ScaleAspectFit;
        button.contentHorizontalAlignment = .Right
        button.ngl_addAction(forControlEvents: .TouchUpInside, withCallback: {
            (Void) -> Void in
            self.actionFloatView.hide(!self.actionFloatView.hidden)
        })
        let barButton = UIBarButtonItem(customView: button)
        let gapItem = UIBarButtonItem(barButtonSystemItem: .FixedSpace, target: nil, action: nil)
        gapItem.width = -7 //fix the space
        self.navigationItem.setRightBarButtonItems([gapItem, barButton], animated: true)
    }
    
    func initActionFloatView() {
        //Init ActionFloatView
        self.actionFloatView = ActionFloatView()
        self.actionFloatView.delegate = self
        self.view.addSubview(self.actionFloatView)
        self.actionFloatView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(UIEdgeInsetsMake(64, 0, 0, 0))
        }
    }
    
    func segmentedSetting() {
        segmentedControl = UISegmentedControl(items: ["Contacts","Teams"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.center=self.view.center
        segmentedControl.addTarget(self, action: #selector(ContactsViewController.segmentedControlAction(_:)), forControlEvents: .ValueChanged)
        self.navigationItem.titleView = segmentedControl
    }
    
    func segmentedControlAction(sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            segment = 0
        case 1:
            segment = 1
        default:
            break;
        }
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    // set the number of sections
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
//    // set titles for each section
//    override func tableView(tableView:UITableView, titleForHeaderInSection section:Int)->String {
//        var headers = self.contactIndexTitleList;
//        return headers[section];
//    }
    
    // set rows in section
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segment == 0 {
            return resultContacts.count
        } else {
            return resultTeams.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var retCell: UITableViewCell
        
        if segment == 0 {
            // Table view cells are reused and should be dequeued using a cell  identifier.
            let cellIdentifier = "ContactsTableViewCell"
            
            let cell = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ContactsTableViewCell
            
            // Fetches the appropriate contact for the data source layout.
            let contact = resultContacts[indexPath.row]
            
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
            retCell = cell
        } else {
            // Table view cells are reused and should be dequeued using a cell  identifier.
            let cellIdentifier = "TeamTableViewCell"
            
            let cell = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TeamTableViewCell
            
            // Fetches the appropriate contact for the data source layout.
            let group = resultTeams[indexPath.row]
            
            cell.teamNameLabel.text = group.name
            cell.teamImageView.image = group.photo
            retCell = cell
        }
        return retCell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
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
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
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
    
    // *Search Result
    
    // Method of UISearchBarDelegate，called when the search text changed
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if segment == 0 {
            // show all the cell when there's no input
            if searchText == "" {
                self.resultContacts = self.contacts
            }
            else { // Match the input regardless of the Uppercase
                self.resultContacts = []
                for contact in self.contacts {
                    if contact.name.lowercaseString.hasPrefix(searchText.lowercaseString) {
                        self.resultContacts.append(contact)
                    }
                }
            }
        } else {
            // show all the cell when there's no input
            if searchText == "" {
                self.resultTeams = self.teams
            }
            else { // Match the input regardless of the Uppercase
                self.resultTeams = []
                for group in self.teams {
                    if group.name.lowercaseString.hasPrefix(searchText.lowercaseString) {
                        self.resultTeams.append(group)
                    }
                }
            }
        }
        
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    // *Prepare for segue
    
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
        else if segue.identifier == "teamDetail" {
            let teamDetailTableViewController = segue.destinationViewController as! TeamDetailTableViewController
            
            // Get the cell that generated this segue
            if let selectedContactCell = sender as? TeamTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedContactCell)!
                let selectedTeam = teams[indexPath.row]
                teamDetailTableViewController.group = selectedTeam
            }
        }
    }
}

// MARK: - @protocol ActionFloatViewDelegate
extension ContactsViewController: ActionFloatViewDelegate {
    func floatViewTapItemIndex(type: ActionFloatViewItemType) {
//        log.info("floatViewTapItemIndex:\(type)")
        switch type {
        case .CreateTeams:
            self.hidesBottomBarWhenPushed = true
            let sb = UIStoryboard(name: "contactsSB", bundle: nil)
            let skip = sb.instantiateViewControllerWithIdentifier("TeamCreation") 
            self.navigationController?.pushViewController(skip, animated: true)
            self.hidesBottomBarWhenPushed = false
            break
        case .AddContacts:
            self.hidesBottomBarWhenPushed = true
            let sb = UIStoryboard(name: "contactsSB", bundle: nil)
            let skip = sb.instantiateViewControllerWithIdentifier("AddContact")
            self.navigationController?.pushViewController(skip, animated: true)
//            let addContactTableViewController = AddContactTableViewController()
//            self.navigationController?.pushViewController(addContactTableViewController, animated: true)
            self.hidesBottomBarWhenPushed = false
            break
        }
    }
}

/*
 Block of UIControl
 */
public class ClosureWrapper1 : NSObject {
    let _callback : Void -> Void
    init(callback : Void -> Void) {
        _callback = callback
    }
    
    public func invoke() {
        _callback()
    }
}

var AssociatedClosure1: UInt8 = 0

extension UIControl {
    private func ngl_addAction(forControlEvents events: UIControlEvents, withCallback callback: Void -> Void) {
        let wrapper = ClosureWrapper1(callback: callback)
        addTarget(wrapper, action:#selector(ClosureWrapper1.invoke), forControlEvents: events)
        objc_setAssociatedObject(self, &AssociatedClosure1, wrapper, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}


