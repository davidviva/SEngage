//
//  ContactDetailTableViewController.swift
//  SEngage
//
//  Created by Yan Wu on 3/23/16.
//  Copyright © 2016 Avaya. All rights reserved.
//

import UIKit

class ContactDetailTableViewController: UITableViewController {
    
    // MARK: Properties

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBAction func scopiaAction(sender: UIButton) {
    }

    
    @IBAction func photoDetail(sender: UITapGestureRecognizer) {
        
    }
    
    var contact: Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Profile"
        // Set up views if editing an exisiting contact or see details
        
        if let contact = contact {
            nameLabel.text = contact.name
            imageView.image = contact.photo
            emailLabel.text = contact.email
            phoneLabel.text = contact.phone
        }
    }
    
    @IBAction func messageAction(sender: AnyObject) {
        skipToChat()
    }
    
    func skipToChat() {
        let chatViewController = ChatViewController()
        chatViewController.contact = contact
//        self.presentViewController(chatViewController, animated: true, completion: nil)
        self.navigationController?.pushViewController(chatViewController, animated: true)
    }
}
