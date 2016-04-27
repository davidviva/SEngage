//
//  PublicMethods.swift
//  SEngage
//
//  Created by Yan Wu on 4/14/16.
//  Copyright © 2016 Avaya. All rights reserved.
//

import UIKit

class PublicMethods {
    // Scopia
    static func makeScopiaHttpLink(extensionStr:String)->String?{
        if(extensionStr.characters.count>4){
            if(extensionStr[extensionStr.startIndex] == "+"){
                return PublicStrings.SCOPIA_PREFIX_HTTP + extensionStr.substringFromIndex(extensionStr.startIndex.advancedBy(1))
            }else{
                return PublicStrings.SCOPIA_PREFIX_HTTP + extensionStr
            }
        }else{
            return nil
        }
    }
    static func makeScopiaLink(extensionStr:String)->String?{
        if(extensionStr.characters.count>4){
            if(extensionStr[extensionStr.startIndex] == "+"){
                return PublicStrings.SCOPIA_PREFIX +  extensionStr.substringFromIndex(extensionStr.startIndex.advancedBy(1))
            }else{
                return PublicStrings.SCOPIA_PREFIX + extensionStr
            }
        }else{
            return nil
        }
    }
    
    static func enterScopiaRoomWithExtension(extensionStr:String) {
        // Process the extension string first
        var scopiaLink:String = "";
        var httpLink:String = ""
        if(extensionStr.characters.count>4){
            if(extensionStr[extensionStr.startIndex] == "+"){
                scopiaLink = PublicStrings.SCOPIA_PREFIX +  extensionStr.substringFromIndex(extensionStr.startIndex.advancedBy(1))
                httpLink = PublicStrings.SCOPIA_PREFIX_HTTP +  extensionStr.substringFromIndex(extensionStr.startIndex.advancedBy(1))
            }else{
                scopiaLink = PublicStrings.SCOPIA_PREFIX + extensionStr
                httpLink = PublicStrings.SCOPIA_PREFIX_HTTP + extensionStr
            }
        }else{
            scopiaLink = PublicStrings.SCOPIA_PREFIX
            httpLink = PublicStrings.SCOPIA_PREFIX_HTTP
        }
        if (UIApplication.sharedApplication().canOpenURL(NSURL(string: scopiaLink)!)){
            UIApplication.sharedApplication().openURL(NSURL(string: scopiaLink)!)
        } else{
            UIApplication.sharedApplication().openURL(NSURL(string: httpLink)!)
        }
    }
    
    static func enterScopiaRoomWithMeetingId(meetingId:String) {
        let linkStr = PublicStrings.SCOPIA_PREFIX_HTTP_FORWARD + meetingId;
        enterScopiaRoomWithHttpLink(linkStr)
    }
    
    static func enterScopiaRoomWithHttpLink(linkStr:String) {
        if(linkStr.characters.count > 4){
            let scopiaLink:String = "scopia:" + linkStr;
            if(UIApplication.sharedApplication().canOpenURL(NSURL(string: scopiaLink)!)){
                UIApplication.sharedApplication().openURL(NSURL(string: scopiaLink)!)
            }else{
                UIApplication.sharedApplication().openURL(NSURL(string: linkStr)!)
            }
        }
    }
    
    // 

}