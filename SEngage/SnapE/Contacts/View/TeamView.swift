//
//  TeamView.swift
//  SEngage
//
//  Created by Yan Wu on 4/28/16.
//  Copyright © 2016 Avaya. All rights reserved.
//

import UIKit

class TeamView: UITableView {
    var teams = [Group]()
    
    func viewDidLoad() {
        teams = GenerateData.generateTeams(10)
        teams.sortInPlace({$0.name < $1.name})

    }
    
    // set the number of sections
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell  identifier.
        let cellIdentifier = "TeamTableViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TeamTableViewCell
        
        // Fetches the appropriate contact for the data source layout.
        let group = teams[indexPath.row]
        
        cell.teamNameLabel.text = group.name
        cell.teamImageView.image = group.photo

        return cell
    }

}
