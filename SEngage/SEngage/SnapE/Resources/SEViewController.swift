//
//  SEViewController.swift
//  SEngage
//
//  Created by Yan Wu on 4/20/16.
//  Copyright © 2016 Avaya. All rights reserved.
//

import UIKit

class SEViewController: UIViewController, UIGestureRecognizerDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let target = self.navigationController?.interactivePopGestureRecognizer!.delegate
        let pan = UIPanGestureRecognizer(target:target,
                                         action:Selector("handleNavigationTransition:"))
        pan.delegate = self
        self.view.addGestureRecognizer(pan)
        self.navigationController?.interactivePopGestureRecognizer!.enabled = false
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer:
        UIGestureRecognizer) -> Bool {
        if self.childViewControllers.count == 1 {
            return false
        }
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
}