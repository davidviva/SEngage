//
//  SnapBaseModel.swift
//  SEngage
//
//  Created by Yan Wu on 5/17/16.
//  Copyright © 2016 Avaya. All rights reserved.
//

import Foundation

enum GenderType: Int {
    case Female = 0, Male
}


/* Message Content Type:
 0 - Text
 1 - Image
 2 - Voice
 3 - System Notifications
 4 - File
 110 - Time
 */
enum MessageContentType: String {
    case Text
    case Image
//    case Voice = "2"
//    case System = "3"
//    case File = "4"
//    case Time
}


//服务器返回的是字符串
enum MessageFromType: String {
    //消息来源类型
    case System = "0"
    case Personal = "1"
    case Group  = "2"
    
//    //消息类型对应的占位图
//    var placeHolderImage: UIImage {
//        switch (self) {
//        case .Personal:
//            return TSAsset.Icon_avatar.image
//        case .System, .Group, .PublicServer, PublicSubscribe:
//            return TSAsset.Icon_avatar.image
//        }
//    }
}

// The status of message
enum MessageSendSuccessType: Int {
    case Success = 0
    case Failed
    case Sending
}