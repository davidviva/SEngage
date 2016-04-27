//
//  RootViewController.swift
//  SEngage
//
//  Created by Yan Wu on 4/12/16.
//  Copyright © 2016 Avaya. All rights reserved.
//

import UIKit

class RootViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Settings for the navigation bar
//        UINavigationBar.appearance().barStyle = UIBarStyle.Black
        UINavigationBar.appearance().barTintColor = AppTheme.AVAYA_RED_COLOR
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(17.0), NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        // Change the color of tab title to green if selected
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : UIColor(hexString: "68BB1E")!], forState: .Selected)
        
        configurationRootViewController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configurationRootViewController() -> UITabBarController {
        
        // Initial the chatList tab
        let chatCtrl = UIStoryboard(name: "ChatListSB", bundle: nil).instantiateInitialViewController() as! ChatListTableViewController
        chatCtrl.tabBarItem.title = "Chats"
        chatCtrl.tabBarItem.image = UIImage(named: "tabbar_mainframe")?.imageWithRenderingMode(.AlwaysOriginal)
        chatCtrl.tabBarItem.selectedImage = UIImage(named: "tabbar_mainframeHL")?.imageWithRenderingMode(.AlwaysOriginal)
        let chatNavigationController = UINavigationController(rootViewController: chatCtrl)
        
        // Initial the contacts tab
        let contactsCtrl = UIStoryboard(name: "contactsSB", bundle: nil).instantiateInitialViewController() as! ContactsTableViewController
        contactsCtrl.tabBarItem.title = "Contacts"
        contactsCtrl.tabBarItem.image = UIImage(named: "tabbar_contacts")?.imageWithRenderingMode(.AlwaysOriginal)
        contactsCtrl.tabBarItem.selectedImage = UIImage(named: "tabbar_contactsHL")?.imageWithRenderingMode(.AlwaysOriginal)
        let contactsNavigationController = UINavigationController(rootViewController: contactsCtrl)
        
        // Initial the Me tab
        let meCtrl = UIStoryboard(name: "MeSB", bundle: nil).instantiateInitialViewController() as! MeTableViewController
        meCtrl.tabBarItem.title = "Me"
        meCtrl.tabBarItem.image = UIImage(named: "tabbar_me")?.imageWithRenderingMode(.AlwaysOriginal)
        meCtrl.tabBarItem.selectedImage = UIImage(named: "tabbar_meHL")?.imageWithRenderingMode(.AlwaysOriginal)
        let meNavigationController = UINavigationController(rootViewController: meCtrl)
        
        self.viewControllers = [chatNavigationController, contactsNavigationController, meNavigationController]
        return self
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
