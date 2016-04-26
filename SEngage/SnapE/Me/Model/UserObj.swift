//
//  UserObj.swift
//  SEngage
//
//  Created by Yan Wu on 4/26/16.
//  Copyright © 2016 Avaya. All rights reserved.
//

import UIKit

class UserObj {
    var name: String
    var phone: String
    var email: String
    var photo: UIImage?
    var status: String
    var contacts = Array<Contact>()
    
    // MARK: Initialization
    init?(name: String, photo: UIImage?, email: String, phone: String, status: String, contacts: Array<Contact>){
        // Initialize stored properties.
        self.name = name
        self.phone = phone
        self.email = email
        self.photo = photo
        self.status = status
        self.contacts = contacts
        
        // Initialization should fail if there is no name
        if name.isEmpty {
            return nil
        }
    }
}
