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

        UINavigationBar.appearance().barTintColor = UIColor(hexString: "39383d")
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(17.0), NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : UIColor(hexString: "68BB1E")!], forState: .Selected)
        
        // Initial the Me tab
        let meCtrl = UIStoryboard(name: "MeSB", bundle: nil).instantiateInitialViewController() as! MeTableViewController
        meCtrl.tabBarItem.title = "Me"
        meCtrl.tabBarItem.image = UIImage(named: "tabbar_me")?.imageWithRenderingMode(.AlwaysOriginal)
        meCtrl.tabBarItem.selectedImage = UIImage(named: "tabbar_meHL")?.imageWithRenderingMode(.AlwaysOriginal)
        let meNavigationController = UINavigationController(rootViewController: meCtrl)
        
        // Create tabBarController
        let tabBarController = UITabBarController(nibName: nil, bundle: nil)
        tabBarController.viewControllers = [meNavigationController]

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
