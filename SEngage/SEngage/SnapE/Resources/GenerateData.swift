//
//  GenerateData.swift
//  SEngage
//
//  Created by Yan Wu on 4/26/16.
//  Copyright © 2016 Avaya. All rights reserved.
//

import Foundation
import UIKit

class GenerateData {
    static func generateUser() -> UserObj{
        let profilePhoto = UIImage(named: "tabbar_contacts")!
        let user = UserObj(name: "Hayden", photo: profilePhoto, email: "1", phone: "1", status: "available", contacts: generateContacts(10))!
        return user
    }
    
    static func generateContacts(num: Int) -> Array<Contact>{
        var contacts = [Contact]()
        var count = num
        var photo: UIImage
        var contact: Contact
        
        let image = ["icon1", "icon2", "icon3", "icon4", "icon0", "contact1", "contact2"]
        let name = ["mike", "john", "sunny", "jamy", "peter", "A"]
        let status = ["idle", "available", "busy", "offline"]
        
        while count > 0 {
            photo = UIImage(named: image[random() % 7])!
            contact = Contact(name: name[random() % 6], photo: photo, email: "1", phone: "1", status: status[random() % 4])!
            contacts += [contact]
            count -= 1
        }
        return contacts
    }
    
    static func generateTeams(num: Int) -> Array<Group>{
        var teams = [Group]()
        var count = num
        var photo: UIImage
        var group: Group
        
        let image = ["icon1", "icon2", "icon3", "icon4", "icon0", "contact1", "contact2"]
        let name = ["Kids", "Girls", "Boys", "Men", "Women"]
        
        while count > 0 {
            photo = UIImage(named: image[random() % 7])!
            group = Group(name: name[random() % 5], photo: photo, contacts: generateContacts(10))!
            teams += [group]
            count -= 1
        }
        return teams
    }
    
    static func generateChatListCellModel(num: Int) -> Array<ChatListCellModel> {
        var result = [ChatListCellModel]()
        var contacts = generateContacts(num)
        var count = num
        
        var contact: Contact
        var lastMessage: String
        var timer: String
        var unreadNumber: Int
        
        // just for test message
        let number = [21, 2, 100, 0, 33]
        let time = ["13:14", "23:45", "Yesterday", "Friday", "15/10/19"]
        let message = ["iPhone 6s 和 iPhone 6s Plus can be used within CMCC network", "如果你从 apple.com 购买 iPhone，则此 iPhone 为无合约 iPhone。你可以直接联系运营商，了解适用于 iPhone 的服务套餐。", "http://www.apple.com/cn/iphone-6s/", "Hello world", "do you know who I am"]
        
        while count > 0 {
            unreadNumber = number[random() % 5]
            lastMessage = message[random() % 5]
            timer = time[random() % 5]
            contact = contacts[count - 1]
            let cell = ChatListCellModel(contact: contact, lastMessage: lastMessage, timer: timer, unreadNumber: unreadNumber)
            result += [cell]
            count -= 1
        }
        return result
    }
}

