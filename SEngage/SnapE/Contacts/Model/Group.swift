//
//  Group.swift
//  SEngage
//
//  Created by Yan Wu on 4/28/16.
//  Copyright © 2016 Avaya. All rights reserved.
//

import UIKit

class Group {
    var photo: UIImage?
    var name: String
    var contacts = Array<Contact>()
    
    // MARK: Initialization
    init?(name: String, photo: UIImage?, contacts: Array<Contact>){
        // Initialize stored properties.
        self.photo = photo
        self.name = name
        self.contacts = contacts
        
        // Initialization should fail if there is no name
        if name.isEmpty {
            return nil
        }
    }
}
