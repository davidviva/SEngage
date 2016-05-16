//
//  ChatListTableViewController.swift
//  SEngage
//
//  Created by Yan Wu on 3/28/16.
//  Copyright © 2016 Avaya. All rights reserved.
//

import UIKit

class ChatListTableViewController: UITableViewController {

    var contacts = [Contact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Chats"
        contacts = GenerateData.generateContacts(20)
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
        var cell = tableView.dequeueReusableCellWithIdentifier("messageListCell") as? ChatListCell
        if cell == nil {
            cell = ChatListCell(style: .Subtitle, reuseIdentifier: "messageListCell")
            let contact = contacts[indexPath.row]
            cell?.iconView.image = contact.photo
            cell?.userNameLabel.text = contact.name
            cell?.messageLabel.text = message[random() % 5]
            cell?.timerLabel.text = time[random() % 5]
        }
        
        return cell!
    }
    
    
    // just for test message
    let time = ["13:14", "23:45", "Yesterday", "Friday", "15/10/19"]
    let message = ["iPhone 6s 和 iPhone 6s Plus 可使用中国移动、中国联通或中国电信的网络", "如果你从 apple.com 购买 iPhone，则此 iPhone 为无合约 iPhone。你可以直接联系运营商，了解适用于 iPhone 的服务套餐。", "http://www.apple.com/cn/iphone-6s/", "你是我的眼", "do you know who I am"]
    
    
    // Click the cell to enter into a chat
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        let chatViewController = ChatViewController()
        chatViewController.contact = contacts[indexPath.row]
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
