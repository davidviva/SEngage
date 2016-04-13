//
//  AppSettings.swift
//  SEngage
//
//  Created by Yan Wu on 4/11/16.
//  Copyright © 2016 Avaya. All rights reserved.
//

import Foundation
class AppSettings{
    class var NOTIFICATION_EXPIRE_TIME : NSTimeInterval {
        return 300; // Five mimutes
    }
    
    class var NOTIFICATION_FEEDBACK_EXPIRE_TIME : NSTimeInterval {
        return 58;
    }
    
    class var RECONNECT_TIMER_INTERVAL_DEFAULT: NSTimeInterval{
        return 60;
    }
}