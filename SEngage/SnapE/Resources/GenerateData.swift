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
}

