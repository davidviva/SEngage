//
//  AppTheme.swift
//  SEngage
//
//  Created by Yan Wu on 4/11/16.
//  Copyright © 2016 Avaya. All rights reserved.
//

import Foundation
import UIKit

class AppTheme{
    // Text font
//    static var FONT = "Avenir-Book"
//    static var FONT_BOLD = "Avenir-Black"
//    static var FONT_SEMI_BOLD = "Avenir-Heavy"
//    static var FONT_LIGHT = "Avenir-Light"
    
    // Cell Height
    static var CONTACT_CELL_HEIGHT: CGFloat = 64.0
    
    // UIColors
    static var PRIMARY_TEXT_COLOR = UIColor.blackColor()
    static var SECONDARY_TEXT_COLOR = UIColor(white:0.6,alpha:1.0);
    
    static var AVAYA_RED_COLOR = UIColor(red: 0.8196, green: 0.0902, blue: 0.0902, alpha: 1)
    static var AVAYA_GRAY_COLOR = UIColor(red: 0.6000, green: 0.6000, blue: 0.6000, alpha: 1)
    static var AVAYA_RED_COLOR_LIGHT = UIColor(red: 0.79216, green: 0.1255, blue: 0.1529, alpha: 1)
    
    static var STATUS_ONLINE_COLOR = UIColor(red: 0.29804, green: 0.6863, blue: 0.3137, alpha: 1)
    static var STATUS_OFFLINE_COLOR = UIColor(red: 0.5412, green: 0.5412, blue: 0.5412, alpha: 1)
    static var STATUS_BUSY_COLOR = AVAYA_RED_COLOR
    static var STATUS_IDEL_COLOR = UIColor.orangeColor()
    
}