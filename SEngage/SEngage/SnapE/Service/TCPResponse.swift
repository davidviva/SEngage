//
//  TCPResponse.swift
//  SnapE
//
//  Created by WangXin on 4/7/16.
//  Copyright © 2016 WangXin. All rights reserved.
//

import Foundation

class TCPResponse {
    /**
     Read and process response
     */
    
    func readResponse() -> Msg {
        /*
         Read response
         */
        var msg = Msg()
        if let data = tcpsocket.read(4){
            msg = decoder(data)
        } else {
            print("Response with No Data!")
        }
        return msg
    }
    
    /*
     Decode response which is with prefix
     Parameter
     data:[UInt8] --- raw bytes data
     return
     msg: Msg --- result without prefix
     */
    
    func decoder(data: [UInt8]) -> Msg {
        var msg: Msg = Msg()
        if data.count == 4 {
            let ndata = NSData(bytes: data, length: 4)
            var len: UInt32 = 0
            ndata.getBytes(&len, length: 4)
            len = UInt32(bigEndian: len)
            var contentLength = Int(len)
            var tmpbuff: [UInt8] = [UInt8]()
            while (contentLength >= 1024) {
                print(contentLength)
                tmpbuff = tmpbuff + tcpsocket.read(1024)!
                contentLength = contentLength - 1024
            }
            print("2222: \(contentLength)")
            if var rsbuff = tcpsocket.read(contentLength) {
                //                    print(rsbuff)
                if rsbuff.count == 3 {
                    print(rsbuff)
                    let wtf = NSData(bytes: rsbuff, length: rsbuff.count)
                    print("nsdata:\(wtf)")
                    let wtf2 = NSString(data: wtf, encoding: NSUTF8StringEncoding)
                    print("string: \(wtf2)")
                    var wtf3: UInt32 = 0
                    ndata.getBytes(&wtf3, length: 3)
                    wtf3 = UInt32(bigEndian: wtf3)
                    print("wtf3: \(wtf3)")
                    
                } else {
                    print(contentLength)
                    do {
                        rsbuff = tmpbuff + rsbuff
                        //                    print(rsbuff.count)
                        msg = try Msg.parseFromData(NSData(bytes: rsbuff, length: rsbuff.count))
                    } catch let e as NSError {
                        print("Decoder Error: \(e.localizedDescription)")
                    }
                }
            } else {
                print("Content Empty!")
            }
        } else {
            print("Read Length Of Content Error!")
        }
        return msg
    }
    
    func processRespMsg(msg: Msg) {
        /* 
         Process response based on message types
         Parameter
            msg: Msg --- Response body without prefix
        */
        switch msg.msgtype {
            case Msg.Types.LoginResp:
                loginResp(msg)
            case Msg.Types.ConnectResp:
                connectResp(msg)
            case Msg.Types.SearchContactResult:
                searchContactResp(msg)
            case Msg.Types.ContactUpdateResp:
                contactUpdateResp(msg)
            case Msg.Types.StatusNotice:
                do {
                    let content: StatusNoticeResponse = try StatusNoticeResponse.parseFromData(msg.body)
                    print(content)
                } catch let e as NSError {
                    print("@@@@@: \(e.localizedDescription)")
                }
            default:
                print(msg.msgtype)
                print("Response With inValid Type!")
        }
    }
    
    /*
     Variables and functions for closure
     */
    var loginClosure: Closure.LoginClosure?
    var contactUpdateClosure: Closure.ContactUpdateClosure?
    var connectClosure: Closure.ConnectClosure?
    var searchContactClosure: Closure.SearchContactClosure?
    
    func loginClosure(closure: Closure.LoginClosure) {
        self.loginClosure = closure
    }
    
    func ContactUpdateClosure(closure: Closure.ContactUpdateClosure) {
        self.contactUpdateClosure = closure
    }
    
    func ConnectClosure(closure: Closure.ConnectClosure) {
        self.connectClosure = closure
    }
    
    func SearchContactClosure(closure: Closure.SearchContactClosure) {
        self.searchContactClosure = closure
    }
    
    /*
     Functions for processing response
     */
    
    func searchContactResp(msg: Msg) {
        do {
            if let content: SearchContactResponse = try SearchContactResponse.parseFromData(msg.body) {
                self.searchContactClosure!(content)
            }
        } catch let e as NSError {
            print("Login Response Error: \(e.localizedDescription)")
        }
    }
    
    func connectResp(msg: Msg) {
        do {
            if let content: ConnectResponse = try ConnectResponse.parseFromData(msg.body) {
                self.connectClosure!(content)
            }
        } catch let e as NSError {
            print("Login Response Error: \(e.localizedDescription)")
        }
    }
    
    func loginResp(msg: Msg) {
        do {
            if let content: LoginResponse = try LoginResponse.parseFromData(msg.body) {
                self.loginClosure!(content)
            }
        } catch let e as NSError {
            print("Login Response Error: \(e.localizedDescription)")
        }
    }
    
    func contactUpdateResp(msg: Msg) {
        do {
            if let content: ContactUpdateResponse = try ContactUpdateResponse.parseFromData(msg.body) {
                self.contactUpdateClosure!(content)
            }
        } catch let e as NSError {
            print("Contact Update Response Error: \(e.localizedDescription)")
        }
    }
}