//
//  MeTableViewController.swift
//  SEngage
//
//  Created by Yan Wu on 3/29/16.
//  Copyright © 2016 Avaya. All rights reserved.
//

import UIKit

class MeTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Profile"
        
        // 去掉尾部多余行？？？
        self.tableView.tableFooterView = UIView(frame:CGRectZero)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
