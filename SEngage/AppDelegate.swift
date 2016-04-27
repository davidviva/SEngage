//
//  AppDelegate.swift
//  SEngage
//
//  Created by Yan Wu on 4/11/16.
//  Copyright © 2016 Avaya. All rights reserved.
//

import UIKit


// Establish TCP channel
var tcpsocket = TCPClient(addr: ServerConfig.addr, port: ServerConfig.port)
var tcpRequest = TCPRequest()
var tcpResponse = TCPResponse()

var reqQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
var respQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
//var realmQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
//let dbService = LocalDBService()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var socketConnection: Bool = false
    var socketErrMsg: String = ""
    
    var stopThread: Bool = false
    var timer: NSTimer?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        connectSocket()
        runThread()
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        
        closeSocket()
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        connectSocket()
        runThread()
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        closeSocket()
    }
    
    func runThread() {
        dispatch_async(respQueue) { () -> Void in
            print("Thread Go!")
            while self.socketConnection {
                print("Loop Go!")
                //Connect
                self.timer?.invalidate()
                let msg: Msg = tcpResponse.readResponse()
                if msg.hasMsgtype {
                    dispatch_async(dispatch_get_main_queue(), {
                        //                        print("ok")
                        tcpResponse.processRespMsg(msg)
                    })
                } else {
                    self.timer = NSTimer(timeInterval: 60, target: self, selector: #selector(AppDelegate.threadHandler), userInfo: nil, repeats: true)
                    print("empty")
                    if self.stopThread {
                        break
                    }
                }
            }
            print("Loop Stop!")
        }
    }
    
    func threadHandler() {
        self.stopThread = true
    }
    
    // Initialize socket connector
    func connectSocket() {
        (self.socketConnection, self.socketErrMsg) = tcpsocket.connect(timeout: 5)
        if self.socketConnection {
            print("Connection success!")
        } else {
            print("Socket Connected Error: \(self.socketErrMsg)")
        }
    }
    
    func closeSocket() {
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
}



