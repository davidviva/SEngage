//
//  Contact.swift
//  SEngage
//
//  Created by Yan Wu on 3/23/16.
//  Copyright © 2016 Avaya. All rights reserved.
//

import UIKit

class Contact {
    // MARK: Properties
    
    var name: String
//    var phone: String
//    var email: String
    var photo: UIImage?
    
    // MARK: Initialization
    init?(name: String, photo: UIImage?){
        // Initialize stored properties.
        self.name = name
//        self.phone = phone
//        self.email = email
        self.photo = photo
        
        // Initialization should fail if there is no name
        if name.isEmpty {
            return nil
        }
    }
    
    /*
    // MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
    aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
    aCoder.encodeObject(photo, forKey: PropertyKey.photoKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
    let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
    
    // Because photo is an optional property of Meal, use conditional cast.
    let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as? UIImage
    
    
    // Must call designated initializer.
    self.init(name: name, photo: photo)
    }
    */
}
