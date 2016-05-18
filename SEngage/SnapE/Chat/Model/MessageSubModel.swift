//
//  MessageSubModel.swift
//  SEngage
//
//  Created by Yan Wu on 5/18/16.
//  Copyright © 2016 Avaya. All rights reserved.
//

import Foundation
import UIKit

class textMessageModel: MessageModel {
    let text: String
    override var messageContentType: MessageContentType {
        get {
            return MessageContentType.Text
        }
    }
    init(incoming: Bool, sentDate: NSDate, contact: Contact, user: UserObj, text: String) {
        self.text = text
        super.init(incoming: incoming, sentDate: sentDate, contact: contact, user: user)
    }
}

class imageMessageModel: MessageModel {
    let image: UIImage
    override var messageContentType: MessageContentType {
        get {
            return MessageContentType.Image
        }
    }
    
    init(incoming: Bool, sentDate: NSDate, contact: Contact, user: UserObj, image: UIImage) {
        self.image = image
        super.init(incoming: incoming, sentDate: sentDate, contact: contact, user: user)
    }
}