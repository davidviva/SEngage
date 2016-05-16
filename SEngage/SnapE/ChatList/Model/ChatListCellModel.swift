//
//  ChatListCellModel.swift
//  SEngage
//
//  Created by Yan Wu on 3/28/16.
//  Copyright © 2016 Avaya. All rights reserved.
//

import Foundation

class ChatListCellModel {
    let contact: Contact!
    let lastMessage: String
    let timer: String

    
    init(contact: Contact, lastMessage: String, timer: String) {
        self.contact = contact
        self.lastMessage = lastMessage
        self.timer = timer
    }
}