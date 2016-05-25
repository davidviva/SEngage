//
//  ChatListTableViewController.swift
//  SEngage
//
//  Created by Yan Wu on 3/28/16.
//  Copyright © 2016 Avaya. All rights reserved.
//

import UIKit

class ChatListTableViewController: UITableViewController {

    var cellDataSource = [ChatListCellModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Chats"
        cellDataSource = GenerateData.generateChatListCellModel(20)
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
        return 20
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell  identifier.
        let cellIdentifier = "ChatListCell"
        let cell = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as? ChatListCell
        let cellModel = cellDataSource[indexPath.row]
        cell!.setCellContnet(cellModel)
        
        return cell!
    }
    
    // Click the cell to enter into a chat
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        let chatViewController = ChatViewController()
        chatViewController.contact = cellDataSource[indexPath.row].contact
        navigationController?.pushViewController(chatViewController, animated: true)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }
    
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
//            // Delete the row from the data source
//            contacts.removeAtIndex(indexPath.row)
            
            // need to save the new contacts array in the db
            save()
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    func save() {
        
    }

}
