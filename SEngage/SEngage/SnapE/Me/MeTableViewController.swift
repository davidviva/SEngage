//
//  MeTableViewController.swift
//  SEngage
//
//  Created by Yan Wu on 4/27/16.
//  Copyright © 2016 Avaya. All rights reserved.
//

import UIKit

class MeTableViewController: UITableViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var user: UserObj!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Profile"
        
        user = GenerateData.generateUser()
        photoImageView.image = user.photo
        nameLabel.text = user.name
        phoneLabel.text = user.phone
        emailLabel.text = user.email
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "changePhoto" {
            let photoViewController = segue.destinationViewController as! PhotoViewController

            photoViewController.user = user
        }
    }
    
    @IBAction func logoutAction(sender: AnyObject) {
    }
}
