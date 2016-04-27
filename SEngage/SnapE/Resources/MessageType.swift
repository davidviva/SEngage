//
//  MessageType.swift
//  SEngage
//
//  Created by Yan Wu on 4/15/16.
//  Copyright © 2016 Avaya. All rights reserved.
//

struct MessageType {
    static let UNKNOWN = 0
    static let CONNECT = 1
    static let CONNECT_RESP = 2
    static let DISCONNECT = 3
    static let DISCONNECT_RESP = 4
    
    static let PLAIN = 100
    
    static let MSG_TO_CONTACT = 121
    static let MSG_TO_CONTACT_RESP = 122
    static let MSG_FROM_CONTACT = 123
    static let MSG_FROM_CONTACT_RESP = 124
    
    static let MSG_TO_GROUP = 125
    static let MSG_TO_GROUP_RESP = 126
    static let MSG_FROM_GROUP = 127
    static let MSG_FROM_GROUP_RESP = 128
    
    static let MSG_REMOVE = 135
    static let MSG_REMOVE_RESP = 136
    static let MSG_UPDATE = 137
    static let MSG_UPDATE_RESP = 138
    
    static let CONTACT_ADD = 200
    static let CONTACT_ADD_RESP = 201
    static let CONTACT_REMOVE = 202
    static let CONTACT_REMOVE_RESP = 203
    
    static let GROUP_CREATE = 211
    static let GROUP_CREATE_RESP = 212
    static let GROUP_REMOVE = 213
    static let GROUP_REMOVE_RESP = 214
    
    static let GROUP_NAME_CHANGE = 217
    static let GROUP_NAME_CHANGE_RESP = 218
    static let GROUP_ADD_MEMBER = 219
    static let GROUP_ADD_MEMBER_RESP = 220
    static let GROUP_REMOVE_MEMBER = 221
    static let GROUP_REMOVE_MEMBER_RESP = 222
    
    static let SEARCH_LDAP_CONTACT = 230
    static let SEARCH_LDAP_CONTACT_RESULT = 231
    
    static let SEARCH_APP = 240
    static let SEARCH_APP_RESULT = 241
    
    static let APP_ADD = 251
    static let APP_ADD_RESP = 252
    static let APP_REMOVE = 253
    static let APP_REMOVE_RESP = 254
    
    //static let RTC_BASE = 300
    //static let RTC_VIDEO = 400
    //static let RTC_AUDIO = 410
    //static let RTC_FILE = 420
    
    static let STATUS_CHANGE = 500
    static let UPDATE_STATUS = 501
    static let CONTACT_PV_CHANGE = 502
    static let GROUP_PV_CHANGE = 503
    
    static let SCOPIA_INV = 1000
    static let SCOPIA_INV_RESP = 1001
    static let AAC_INV = 1001
    static let AND_MANY_MORE_INVS = 1005
}