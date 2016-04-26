//
//  SearchResultTableViewCell.swift
//  SEngage
//
//  Created by Yan Wu on 4/20/16.
//  Copyright © 2016 Avaya. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
    // MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBAction func addAction(sender: UIButton) {
//        if handle != "" {
//            if !dbService.isExisted(self.handle) {
//                dispatch_async(reqQueue, { () -> Void in
//                    tcpRequest.contactAdd(self.handle)
//                })
//            }
//        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}