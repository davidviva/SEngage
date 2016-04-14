//
//  PublicMethods.swift
//  SEngage
//
//  Created by Yan Wu on 4/11/16.
//  Copyright © 2016 Avaya. All rights reserved.
//

import CoreData
import UIKit

class PublicMethods{
    
//    class func getContactSortClosure() -> ((Contact, Contact) -> Bool) {
//        func contactSort(s1: Contact, s2: Contact) -> Bool {
//            if(s1.onlineStatusPriority == s2.onlineStatusPriority){
//                return s1.family_name < s2.family_name
//            }else{
//                return s1.onlineStatusPriority < s2.onlineStatusPriority
//            }
//        }
//        return contactSort;
//    }
    
    class func stringSearchRequest(entityName:String, entityProperty:String, searchStr:String, exactFlag:Bool = false) -> NSFetchRequest {
        let fReq: NSFetchRequest = NSFetchRequest(entityName: entityName)
        if(exactFlag){
            fReq.predicate = NSPredicate(format:"\(entityProperty) like '\(searchStr)'")
        }else{
            fReq.predicate = NSPredicate(format:"\(entityProperty) CONTAINS '\(searchStr)'")
        }
        fReq.returnsObjectsAsFaults = false
        return fReq;
    }
    
    class func stringSearchRequest(entityName:String, entityProperty:String, searchStr:String, sorterName:String, isAscending:Bool = false, exactFlag:Bool = false) -> NSFetchRequest {
        let fReq: NSFetchRequest = NSFetchRequest(entityName: entityName)
        
        if(exactFlag){
            fReq.predicate = NSPredicate(format:"\(entityProperty) like '\(searchStr)'")
        }else{
            fReq.predicate = NSPredicate(format:"\(entityProperty) CONTAINS '\(searchStr)'")
        }
        
        let sorter: NSSortDescriptor = NSSortDescriptor(key: sorterName , ascending: isAscending)
        fReq.sortDescriptors = [sorter]
        
        fReq.returnsObjectsAsFaults = false
        
        return fReq;
    }
    
    class func genSearchAllContactsPredicate(searchStr:String) -> NSPredicate{
        let newSearchStr = searchStr.stringByReplacingOccurrencesOfString("'", withString: "\\'", options: NSStringCompareOptions.LiteralSearch, range: nil)
        let predicate:NSPredicate = NSPredicate(format:"email CONTAINS[cd] '\(newSearchStr)' OR avaya_extension CONTAINS[cd] '\(newSearchStr)' OR family_name CONTAINS[cd] '\(newSearchStr)' OR given_name CONTAINS[cd] '\(newSearchStr)'") //  OR location like '\(searchStr)'
        return predicate
    }
    /*
     class func genSearchContactPredicateByHandle(searchStr:String) -> NSPredicate{
     var predicate:NSPredicate = NSPredicate(format:"handle like '\(searchStr)'")!
     return predicate
     }*/
    
    class func checkSystemVersionLatest() ->Bool{
        switch UIDevice.currentDevice().systemVersion.compare("8.0.0", options: NSStringCompareOptions.NumericSearch) {
        case .OrderedSame, .OrderedDescending:
            //"iOS >= 8.0")
            return true
        case .OrderedAscending:
            //println("iOS < 8.0")
            return false
        default:
            return false
        }
        /*
         if NSProcessInfo().isOperatingSystemAtLeastVersion(NSOperatingSystemVersion(majorVersion: 8, minorVersion: 0, patchVersion: 0)) {
         return true;
         }else{
         return false;
         }*/
    }
//    class func getSystemVersion() ->Int {
//        // Note this method only works on iOS 8 and Above
//        if #available(iOS 8.0, *) {
//            let os = NSProcessInfo().operatingSystemVersion
//        } else {
//            // Fallback on earlier versions
//        }
//        switch (os.majorVersion, os.minorVersion, os.patchVersion) {
//        case (8, _, _):
//            return 8
//        case (7, 0, _):
//            return 7
//        case (7, _, _):
//            // iOS Version between 7 and 8
//            return 7
//        default:
//            // iOS Version below 7.
//            return 6
//        }
//    }
    
    class func getScreenSize() -> CGRect {
        return UIScreen.mainScreen().bounds
    }
    
    class func getScreenWidth() -> CGFloat{
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        return screenSize.width
    }
    
    class func getScreenHeight() -> CGFloat{
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        return screenSize.height
    }
    
    class func getBottomScreenControl(tabHeight:CGFloat, backgroundColor:UIColor = UIColor.redColor()) -> UIView{
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let menuHeight:CGFloat = AppTheme.CONTEXT_BUTTON_HEIGHT
        let viewRect:CGRect = CGRect(x: 0.0, y: screenSize.height - tabHeight - menuHeight , width: screenSize.width, height:menuHeight)
        let view:UIView = UIView(frame: viewRect)
        view.alpha = 0
        view.backgroundColor = backgroundColor
        return view
    }
    

    
    class func enterScopiaRoomWithHttpLink(linkStr:String) {
        if(linkStr.characters.count > 4){
            let scopiaLink:String = "scopia:" + linkStr;
            if(UIApplication.sharedApplication().canOpenURL(NSURL(string: scopiaLink)!)){
                UIApplication.sharedApplication().openURL(NSURL(string: scopiaLink)!)
            }else{
                UIApplication.sharedApplication().openURL(NSURL(string: linkStr)!)
            }
        }
    }
    
    class func serverDateStringToDate(dateStr:String) -> NSDate {
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let rawDate = dateFormatter.dateFromString(dateStr)
        if let date:NSDate = rawDate{
            return date
        }else{
            return NSDate()
        }
    }
    
    class func drawCheckmarkPath() -> UIBezierPath{
        // Checkmark Shape Drawing
        let checkmarkShapePath = UIBezierPath()
        checkmarkShapePath.moveToPoint(CGPointMake(37.52, 12.854))
        checkmarkShapePath.addCurveToPoint(CGPointMake(33.879, 12.775), controlPoint1: CGPointMake(36.575, 11.767), controlPoint2: CGPointMake(34.825, 11.692))
        checkmarkShapePath.addLineToPoint(CGPointMake(18.442, 28.667))
        checkmarkShapePath.addLineToPoint(CGPointMake(13.563, 23.475))
        checkmarkShapePath.addCurveToPoint(CGPointMake(9.85, 23.475), controlPoint1: CGPointMake(12.612, 22.388), controlPoint2: CGPointMake(10.867, 22.388))
        checkmarkShapePath.addCurveToPoint(CGPointMake(9.85, 27.425), controlPoint1: CGPointMake(8.829, 24.558), controlPoint2: CGPointMake(8.829, 26.342))
        checkmarkShapePath.addLineToPoint(CGPointMake(16.546, 34.558))
        checkmarkShapePath.addCurveToPoint(CGPointMake(18.367, 35.333), controlPoint1: CGPointMake(17.058, 35.1), controlPoint2: CGPointMake(17.713, 35.333))
        checkmarkShapePath.addCurveToPoint(CGPointMake(20.188, 34.558), controlPoint1: CGPointMake(19.025, 35.333), controlPoint2: CGPointMake(19.679, 35.025))
        
        checkmarkShapePath.addLineToPoint(CGPointMake(34.75, 18.830))
        checkmarkShapePath.addCurveToPoint(CGPointMake(37.521, 12.854), controlPoint1: CGPointMake(38.467, 15.646), controlPoint2: CGPointMake(38.542, 13.938))
        
        checkmarkShapePath.closePath()
        //checkmarkShapePath.miterLimit = 4;
        return checkmarkShapePath
        //UIColor.whiteColor().setFill()
        //checkmarkShapePath.fill()
    }
    
}