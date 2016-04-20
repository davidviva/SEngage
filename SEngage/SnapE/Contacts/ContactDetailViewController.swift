//
//  ContactDetailViewController.swift
//  SEngage
//
//  Created by Yan Wu on 3/23/16.
//  Copyright © 2016 Avaya. All rights reserved.
//

import UIKit

class ContactDetailViewController: SEViewController {
    
    // MARK: Properties
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var contactPhoto: UIImageView!
    
    var contact: Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up views if editing an exisiting contact or see details
        if let contact = contact {
            contactNameLabel.text = contact.name
            contactPhoto.image = contact.photo
        }
    }
}
