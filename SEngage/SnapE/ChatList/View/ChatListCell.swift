//
//  ChatListCell.swift
//  SEngage
//
//  Created by Yan Wu on 3/28/16.
//  Copyright © 2016 Avaya. All rights reserved.
//

import UIKit

class ChatListCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastMessageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var unreadNumberLabel: UILabel!
    
    func setCellContnet(model: ChatListCellModel) {
        self.avatarImageView.image = model.contact.photo
        self.unreadNumberLabel.text = model.unreadNumber > 99 ? "99+" : String(model.unreadNumber)
        self.unreadNumberLabel.hidden = (model.unreadNumber == 0)
        self.lastMessageLabel.text = model.lastMessage
        self.dateLabel.text = model.timer
        self.nameLabel.text = model.contact.name
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
