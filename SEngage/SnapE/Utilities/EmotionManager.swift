//
//  EmotionManager.swift
//  SEngage
//
//  Created by Yan Wu on 3/23/16.
//  Copyright © 2016 Avaya. All rights reserved.
//

import UIKit

class EmotionManager: NSObject {
    
    var emotionArray: NSArray!
    
    var emotionDict: [String: NSArray]!
    
    /// dispatch_once
    static let shareInstance: EmotionManager = {
        return EmotionManager()
    }()
    
    
    override init() {
        super.init()
        if let fileName = NSBundle.mainBundle().pathForResource("emoji_config", ofType: "json") {
            emotionArray = try! NSJSONSerialization.JSONObjectWithData(NSData(contentsOfFile: fileName)!, options: NSJSONReadingOptions.AllowFragments) as! NSArray
            
            if emotionArray.count > 0 {
                emotionArray.enumerateObjectsUsingBlock({ (objc: AnyObject, index: Int, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
                    let emotionData = objc as! NSArray
                    self.emotionDict = [(emotionData[1] as! String): [emotionData[0], emotionData[2]]]
                })
            }
        }
    }
}
