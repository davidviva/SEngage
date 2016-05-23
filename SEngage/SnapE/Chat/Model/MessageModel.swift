//
//  MessageModel.swift
//  SEngage
//
//  Created by Yan Wu on 5/17/16.
//  Copyright © 2016 Avaya. All rights reserved.
//

import Foundation
import UIKit


class MessageModel {
    var contact: Contact
    var user: UserObj
    var sender: String
    var receiver: String
    var icon: UIImage
    let incoming: Bool
    let sentDate: NSDate
    var messageFromType : MessageFromType = MessageFromType.Personal
    var messageContentType: MessageContentType {
        get {
            return MessageContentType.Text
        }
    }
    
    let dataString: String = {
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let date = NSDate()
        let formater = NSDateFormatter()
        formater.dateFormat = "MM-dd HH:mm"
        var dateStr: String = formater.stringFromDate(date)
        return dateStr
    }()
    
    init(incoming: Bool, sentDate: NSDate, contact: Contact, user: UserObj) {
        self.incoming = incoming
        self.sentDate = sentDate
        self.contact = contact
        self.user = user
        // for test
        if incoming {
            self.sender = contact.name
            self.receiver = user.name
            self.icon = contact.photo!
        } else {
            self.sender = user.name
            self.receiver = contact.name
            self.icon = user.photo!
        }
    }
}