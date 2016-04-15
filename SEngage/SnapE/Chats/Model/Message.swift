//
//  Message.swift
//  SEngage
//
//  Created by Yan Wu on 3/28/16.
//  Copyright © 2016 Avaya. All rights reserved.
//

//
//  Message.swift
//  SnapE-v1
//
//  Created by Yan Wu on 3/28/16.
//  Copyright © 2016 Avaya. All rights reserved.
//

import Foundation
import UIKit

enum MessageType {
    case Text
    case Voice
    case Image
    case Video
}

class Message {
    let incoming: Bool
    let sentDate: NSDate
    var iconName: String
    
    var messageType: MessageType {
        get {
            return MessageType.Text
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
    
    init(incoming: Bool, sentDate: NSDate, iconName: String) {
        self.incoming = incoming
        self.sentDate = sentDate
        self.iconName = iconName
        // for test
        if incoming {
            self.iconName = "icon1"
        } else {
            self.iconName = "icon3"
        }
    }
}

class textMessage: Message {
    let text: String
    override var messageType: MessageType {
        get {
            return MessageType.Text
        }
    }
    init(incoming: Bool, sentDate: NSDate, iconName: String, text: String) {
        self.text = text
        super.init(incoming: incoming, sentDate: sentDate, iconName: iconName)
    }
}


class voiceMessage: Message {
    let voicePath: NSURL
    let voiceTime: NSNumber
    
    override var messageType: MessageType {
        get {
            return MessageType.Voice
        }
    }
    
    init(incoming: Bool, sentDate: NSDate, iconName: String, voicePath: NSURL, voiceTime: NSNumber) {
        self.voicePath = voicePath
        self.voiceTime = voiceTime
        super.init(incoming: incoming, sentDate: sentDate, iconName: iconName)
    }
}

class imageMessage: Message {
    let image: UIImage
    override var messageType: MessageType {
        get {
            return MessageType.Image
        }
    }
    
    init(incoming: Bool, sentDate: NSDate, iconName: String, image: UIImage) {
        self.image = image
        super.init(incoming: incoming, sentDate: sentDate, iconName: iconName)
    }
}


class videoMessage: Message {
    let url: NSURL
    
    override var messageType: MessageType {
        get {
            return MessageType.Video
        }
    }
    
    init(incoming: Bool, sentDate: NSDate, iconName: String, url: NSURL) {
        self.url = url
        super.init(incoming: incoming, sentDate: sentDate, iconName: iconName)
    }
}
