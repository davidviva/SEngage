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
    class var FONT : String {
        return "Avenir-Book";
    }
    class var FONT_BOLD :String {
        return "Avenir-Black";
    }
    class var FONT_SEMI_BOLD :String {
        return "Avenir-Heavy";
    }
    class var FONT_LIGHT :String {
        return "Avenir-Light";
    }
    
    class var PRIMARY_TEXT_COLOR:UIColor {
        return UIColor.blackColor()
    }
    
    class var SECONDARY_TEXT_COLOR:UIColor {
        return UIColor(white:0.6,alpha:1.0);
    }
    
    // UI properties
    class var CONTACT_CELL_HEIGHT : CGFloat {
        return 72;
    }
    class var CONTACT_SECTION_HEADER_HEIGHT : CGFloat {
        return 26;
    }
    class var HISTORY_CELL_HEIGHT : CGFloat {
        return 72;
    }
    class var MYAVAYA_CELL_HEIGHT : CGFloat {
        return 44;
    }
    class var CONTEXT_BUTTON_HEIGHT : CGFloat {
        return 40;
    }
    
    // UIColors
    class var AVAYA_RED_COLOR: UIColor{
        return UIColor(red: 0.8196, green: 0.0902, blue: 0.0902, alpha: 1)
    }
    class var AVAYA_GRAY_COLOR: UIColor{
        return UIColor(red: 0.6000, green: 0.6000, blue: 0.6000, alpha: 1)
    }
    class var AVAYA_RED_COLOR_LIGHT: UIColor{
        return UIColor(red: 0.79216, green: 0.1255, blue: 0.1529, alpha: 1)
    }
    
    class var STATUS_ONLINE_COLOR : UIColor{
        //return UIColor(red: 51, green: 187, blue: 40, alpha: 255)
        return UIColor(red: 0.29804, green: 0.6863, blue: 0.3137, alpha: 1)
    }
    
    class var STATUS_OFFLINE_COLOR : UIColor{
        return UIColor(red: 0.5412, green: 0.5412, blue: 0.5412, alpha: 1)
    }
    
    class var STATUS_SELECTED_COLOR :UIColor{
        //return UIColor(red: 39, green: 145, blue: 153, alpha: 255)
        return UIColor(red: 0, green: 0.5882, blue: 0.5333, alpha: 255)
    }
    
    // CGColors
    class var STATUS_ONLINE_CGCOLOR : CGColor{
        //return UIColor(red: 0.2, green: 0.733333, blue: 0.15686, alpha:255).CGColor
        return UIColor(red: 0.298, green: 0.6863, blue: 0.3137, alpha:255).CGColor
    }
    
    class var STATUS_OFFLINE_CGCOLOR : CGColor{
        return UIColor(red: 0.5411, green: 0.5411, blue: 0.5411, alpha:255).CGColor
    }
    
    class var STATUS_SELECTED_CGCOLOR : CGColor{
        return UIColor(red: 0, green: 0.5882, blue: 0.53333, alpha: 255).CGColor
        //return UIColor(red: 0.15294, green: 0.56863, blue: 0.6, alpha: 255).CGColor
    }
    
}