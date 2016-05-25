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
        
        configurationRootViewController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configurationRootViewController() -> UITabBarController {
        // Change the color of tab title to green if selected
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : UIColor(hexString: "68BB1E")!], forState: .Selected)
        
        // Initial the chatList tab
        let chatCtrl = UIStoryboard(name: "ChatListSB", bundle: nil).instantiateInitialViewController() as! ChatListTableViewController
        chatCtrl.tabBarItem.title = "Chats"
        chatCtrl.tabBarItem.image = UIImage(asset: .Tabbar_chat_unselected)?.imageWithRenderingMode(.AlwaysOriginal)
        chatCtrl.tabBarItem.selectedImage = UIImage(asset: .Tabbar_chat_selected)?.imageWithRenderingMode(.AlwaysOriginal)
        let chatNavigationController = UINavigationController(rootViewController: chatCtrl)
        
        // Initial the contacts tab
        let contactsCtrl = UIStoryboard(name: "contactsSB", bundle: nil).instantiateInitialViewController() as! ContactsViewController
        contactsCtrl.tabBarItem.title = "Contacts"
        contactsCtrl.tabBarItem.image = UIImage(asset: .Tabbar_contacts_unselected)?.imageWithRenderingMode(.AlwaysOriginal)
        contactsCtrl.tabBarItem.selectedImage = UIImage(asset: .Tabbar_contacts_selected)?.imageWithRenderingMode(.AlwaysOriginal)
        let contactsNavigationController = UINavigationController(rootViewController: contactsCtrl)
        
        // Initial the Me tab
        let meCtrl = UIStoryboard(name: "MeSB", bundle: nil).instantiateInitialViewController() as! MeTableViewController
        meCtrl.tabBarItem.title = "Me"
        meCtrl.tabBarItem.image = UIImage(asset: .Tabbar_me_unselected)?.imageWithRenderingMode(.AlwaysOriginal)
        meCtrl.tabBarItem.selectedImage = UIImage(asset: .Tabbar_me_selected)?.imageWithRenderingMode(.AlwaysOriginal)
        let meNavigationController = UINavigationController(rootViewController: meCtrl)
        
        self.viewControllers = [chatNavigationController, contactsNavigationController, meNavigationController]
        return self
    }
}
