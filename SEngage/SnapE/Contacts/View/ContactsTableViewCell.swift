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
    @IBOutlet weak var selectedImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        photoImageView.layer.cornerRadius = 5
        photoImageView.layer.masksToBounds = true
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            self.selectedImageView?.image = UIImage(named: "CellBlueSelected")
        }else {
            self.selectedImageView?.image = UIImage(named: "CellGreySelected")
        }
    }
    
}
