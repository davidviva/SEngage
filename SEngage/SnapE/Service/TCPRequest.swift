//
//  TCPsocket.swift
//  SnapE
//
//  Created by WangXin on 3/24/16.
//  Copyright © 2016 WangXin. All rights reserved.
//

import Foundation


class TCPRequest {
    func connect(username: String, sessionId: String, token: String) {
        /*
         Connect Function
         */
        // Connect Request builder and body
        let connectRequestBuilder = ConnectRequest.Builder()
        let connectRequest: ConnectRequest?
        // Message Base builder and body
        let msgBuilder = Msg.Builder()
        var msg:Msg?
        // connectresponse
        
        do {
            // Initialize connectRequest
            connectRequestBuilder.setUsername(username).setToken(token).setSessionId(sessionId)
            connectRequest = try connectRequestBuilder.build()
            
            //Initialize meassage
            msgBuilder.setBody(connectRequest!.data()).setMsgtype(Msg.Types.Connect)
            msg = try msgBuilder.build()
            
            let (success, errmsg) = tcpsocket.send(data: encoder(msg!))
            if success {
                print("Send Successfully!")
            } else {
                print("Connect Error: \(errmsg)")
            }
            
        } catch let e as NSError {
            print(e.localizedDescription)
        }
    }
    
    func contactUpdate(username: String) {
        // Search Contact Request builder and body
        let contactUpdateRequestBuilder = ContactUpdateRequest.Builder()
        let contactUpdateRequest: ContactUpdateRequest?
        
        // Message Base builder and body
        let msgBuilder = Msg.Builder()
        var msg:Msg?
        
        do {
            // Initialize searchContactRequest
            contactUpdateRequestBuilder.setUsername(username)
            contactUpdateRequest = try contactUpdateRequestBuilder.build()
            
            //Initialize meassage
            msgBuilder.setBody(contactUpdateRequest!.data()).setMsgtype(Msg.Types.ContactUpdate)
            msg = try msgBuilder.build()
            
            let (success, errmsg) = tcpsocket.send(data: encoder(msg!))
            if success {
                print("Send successfully!")
            } else {
                print("Connect Error: \(errmsg)")
            }
            
        } catch let e as NSError {
            print(e.localizedDescription)
        }
    }
    
    func searchContact(pageNum:Int32, keyword: String) {
        /*
         Search Contact Function
         */
        // Search Contact Request builder and body
        let searchContactRequestBuilder = SearchContactRequest.Builder()
        let searchContactRequest: SearchContactRequest?
        
        // Message Base builder and body
        let msgBuilder = Msg.Builder()
        var msg:Msg?

        do {
            // Initialize searchContactRequest
            searchContactRequestBuilder.setKeyword(keyword).setPageNum(pageNum)
            searchContactRequest = try searchContactRequestBuilder.build()
            
            //Initialize meassage
            msgBuilder.setBody(searchContactRequest!.data()).setMsgtype(Msg.Types.SearchContact)
            msg = try msgBuilder.build()
            
            let (success, errmsg) = tcpsocket.send(data: encoder(msg!))
            if success {
                print("Send successfully!")
            } else {
                print("Connect Error: \(errmsg)")
            }
            
        } catch let e as NSError {
            print(e.localizedDescription)
        }
    }
    
    func login(username: String, password: String) {
        /*
         Login Function
         */
        // Login Request builder and body
        let loginRequestBuilder = LoginRequest.Builder()
        let loginRequest: LoginRequest?
        // Message Base builder and body
        let msgBuilder = Msg.Builder()
        var msg: Msg?

        do {
            // Initialize loginRequest
            loginRequestBuilder.setUsername(username).setPassword(password)
            loginRequest = try loginRequestBuilder.build()
            
            // Initialize message
            msgBuilder.setBody(loginRequest!.data()).setMsgtype(Msg.Types.Login)
            msg = try msgBuilder.build()
            
            let (success, errmsg) = tcpsocket.send(data: encoder(msg!))
            if success {
                print("Send Successfully!")
            } else {
                print("Login Error: \(errmsg)")
            }

        } catch let e as NSError {
            print("Login Request Function Error: \(e.localizedDescription)")
        }
    }
    
    func encoder(msg: Msg) -> NSData {
        let msgBytes = Array(UnsafeBufferPointer(start: UnsafePointer<UInt8>(msg.data().bytes), count:  msg.data().length))
        let length = (UInt32)(msg.data().length)
        var bigEndian = length.bigEndian
        let bytePtr = withUnsafePointer(&bigEndian) {
            UnsafeBufferPointer<UInt8>(start: UnsafePointer($0), count: 4)
        }
        let lengthBytes = Array(bytePtr)
        
        let request =  lengthBytes + msgBytes
        let requesttemp = NSData(bytes: request, length: (request.count))
        return requesttemp
    }
}