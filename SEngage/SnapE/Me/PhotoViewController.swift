//
//  PhotoViewController.swift
//  SEngage
//
//  Created by Yan Wu on 4/14/16.
//  Copyright © 2016 Avaya. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    var photo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Photo"
        // Get the size of the screen
        let mainSize = UIScreen.mainScreen().bounds.size
        // Get the image of owl
        photo =  UIImageView(frame:CGRectMake(mainSize.width/2-211/2, 100, 211, 109))
        photo.image = UIImage(named:"default_photo")
        photo.layer.masksToBounds = true
        self.view.addSubview(photo)
        
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
