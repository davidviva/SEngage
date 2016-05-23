//
//  ChatImageCell.swift
//  SEngage
//
//  Created by Yan Wu on 5/18/16.
//  Copyright © 2016 Avaya. All rights reserved.
//

import UIKit

class ChatImageCell: ChatBaseCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundImageView.addConstraint(NSLayoutConstraint(item: backgroundImageView, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 120))
        backgroundImageView.addConstraint(NSLayoutConstraint(item: backgroundImageView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 140))
        contentView.addConstraint(NSLayoutConstraint(item: backgroundImageView, attribute: .Bottom, relatedBy: .Equal, toItem: contentView, attribute: .Bottom, multiplier: 1, constant: -5))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setMessage(message: MessageModel) {
        super.setMessage(message)
        let message = message as! ImageMessageModel
        backgroundImageView.image = message.image
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        
    }
}
