//
//  PublicStrings.swift
//  SEngage
//
//  Created by Yan Wu on 4/12/16.
//  Copyright © 2016 Avaya. All rights reserved.
//

import Foundation

class PublicStrings{
    static let SERVER_IP = "placsvmap01.avaya.com"
        // 135.55.22.156   135.55.22.184  135.55.22.67  dlaswovap02.nonprod.avaya.com  placsvmap01.avaya.com
         //"dlaswovap02.nonprod.avaya.com"//"135.55.32.234";

    
    static let HTTP_SERVER_PREFIX : String = "https://" + SERVER_IP+":8080/";
    
    static let USERNAME_TOOSHORT : String = "The username is too short";
    
    static let PASSWORD_TOOSHORT : String = "The password is too short";
    
    class var SEARCH_KEYWORD_TOOSHORT: String {
        return "The keyword is too short for an accurate search.";
    }
    class var ERROR_ALERT_TITLE: String {
        return "Oops";
    }
    class var LOGIN_CONNECTION_ERROR: String {
        return "Could not connect to Avaya server";
    }
    class var BAD_NETWORK: String {
        return "Could not connect due to of a poor signal."
    }
    class var INVALID_CREDENTIALS: String {
        return "Your username or password is incorrect";
    }
    class var SESSION_EXPIRED: String {
        return "Your session has expired. Please login for security.";
    }
    class var SESSION_EXPIRED_TITLE: String {
        return "Session Expire";
    }
    class var OPPERATION_FAILED_TITLE: String {
        return "Warning";
    }
    class var DELETE_CONTACT_FAILED: String {
        return "Failed to delete the contact remotely";
    }
    class var FAVORITE_CONTACT_FAILED: String {
        return "Failed to add to favorite remotely";
    }
    class var UNFAVORITE_CONTACT_FAILED: String {
        return "Failed to remove favorite remotely";
    }
    class var NEED_SETUP_EMAIL: String {
        return "You do not have an Email account connected to this device, please set one up.";
    }
    class var IS_NOT_AN_PHONE:String{
        return "Cannot make a phone call because this is not an iPhone device."
    }
    
    class var SCOPIA_PREFIX:String{
        return "scopia:http://scopia.avaya.com/scopia?ID=1300"
    }
    class var SCOPIA_PREFIX_HTTP:String{
        return "http://scopia.avaya.com/scopia?ID=1300"
    }
    class var SCOPIA_PREFIX_HTTP_FORWARD:String{
        return "http://scopia.avaya.com/scopia?ID="
    }
    class var MEETING_ID_PREFIX : String{
        return "1300"
    }
    class var FAKE_TOKEN_STRING : String{
        return "**********"
    }
}