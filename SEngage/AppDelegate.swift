//
//  AppDelegate.swift
//  SEngage
//
//  Created by Yan Wu on 4/11/16.
//  Copyright © 2016 Avaya. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var socketConnection: Bool = false
    var socketErrMsg: String = ""
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        // TODO: Initialize socket connector
        (self.socketConnection, self.socketErrMsg) = tcpsocket.connect(timeout: 5)
        if self.socketConnection {
            print("Connection success!")
        } else {
            print("Socket Connected Error: \(self.socketErrMsg)")
        }
        
        runThread()
        
        return true
    }
    
    func runThread() {
        dispatch_async(respQueue) { () -> Void in
            print("Thread Go!")
            while self.socketConnection {
                //Connect
                let msg: Msg = tcpResponse.readResponse()
                if msg.hasMsgtype {
                    dispatch_async(dispatch_get_main_queue(), {
                        //                        print("ok")
                        tcpResponse.processRespMsg(msg)
                    })
                } else {
                    print("empty")
                }
            }
        }
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        // socket connector.disconnect()
        let (success, errmsg) = tcpsocket.close()
        if success {
            //Submission
            print("Socket Close!")
            self.socketConnection = false
        } else {
            print("Socket Closed Error: \(errmsg)")
        }
        
        
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        // Socket connector.connect()
        (self.socketConnection, self.socketErrMsg) = tcpsocket.connect(timeout: 5)
        if self.socketConnection {
            //Submission
            print("Connection success!")
        } else {
            print("Socket Closed Error: \(self.socketErrMsg)")
        }
        
        runThread()
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        let (success, errmsg) = tcpsocket.close()
        if success {
            //Submission
            print("Socket Close!")
            self.socketConnection = false
        } else {
            print("Socket Closed Error: \(errmsg)")
        }
    }
}

var tcpsocket = TCPClient(addr: ServerConfig.addr, port: ServerConfig.port) // Establish TCP channel
var tcpRequest = TCPRequest() // TCP request object
var tcpResponse = TCPResponse() // TCP response object
var reqQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
var respQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)


