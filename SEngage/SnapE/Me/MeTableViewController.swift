//
//  MeTableViewController.swift
//  SEngage
//
//  Created by Yan Wu on 4/27/16.
//  Copyright © 2016 Avaya. All rights reserved.
//

import UIKit

class MeTableViewController: UITableViewController {
<<<<<<< HEAD

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    var user: UserObj!
=======
>>>>>>> origin/master
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Profile"
<<<<<<< HEAD
        user = GenerateData.generateUser()
        photoImageView.image = user.photo
        nameLabel.text = user.name
        phoneLabel.text = user.phone
        emailLabel.text = user.email
=======
        
        // 去掉尾部多余行？？？
        self.tableView.tableFooterView = UIView(frame:CGRectZero)
        
>>>>>>> origin/master
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "changePhoto" {
            let photoViewController = segue.destinationViewController as! PhotoViewController
   
            photoViewController.user = user
        }
    }
}
