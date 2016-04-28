//
//  ContactsTableViewCell.swift
//  SEngage
//
//  Created by Yan Wu on 3/23/16.
//  Copyright © 2016 Avaya. All rights reserved.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {
    // MARK: Properties
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var statusImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        photoImageView.layer.cornerRadius = 5
        photoImageView.layer.masksToBounds = true
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
