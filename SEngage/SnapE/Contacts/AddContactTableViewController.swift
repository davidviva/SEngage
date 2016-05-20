//
//  AddContactTableViewController.swift
//  SEngage
//
//  Created by Yan Wu on 4/20/16.
//  Copyright © 2016 Avaya. All rights reserved.
//

import UIKit
import MJRefresh

class AddContactTableViewController: UITableViewController, UISearchBarDelegate {
    
    // Identify the footer for loading more
    let footer = MJRefreshAutoNormalFooter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Contacts"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    
    // set rows in section
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    // Load more at the bottom
    func footerSetting() {
        footer.automaticallyHidden = true
        
        // Drag up to load more
        footer.setRefreshingTarget(self, refreshingAction: #selector(self.footerRefresh))
        // self.mj_footer = footer
        
        // set the text for footer
        footer.setTitle("Click or drag up to load more", forState:MJRefreshState.Idle)
        footer.setTitle("Loading more ...", forState: MJRefreshState.Refreshing)
        footer.setTitle("No more data", forState: MJRefreshState.NoMoreData)
    }
    //    var index = 0
    func footerRefresh(){
        // load more
        footer.endRefreshing()
    }
}
