//
//  NavigationBarEx.swift
//  SEngage
//
//  Created by Yan Wu on 5/19/16.
//  Copyright © 2016 Avaya. All rights reserved.
//

import Foundation
import UIKit

/// PDF image size : 20px * 20px is perfect one
public typealias ActionHandler = (Void) -> Void

public extension UIViewController {
    //Back bar with custom action
    func leftBackAction(action: ActionHandler) {
        self.leftBackBarButton(UIImage(asset:.Back_icon), action: action)
    }
    
    //Back bar with go to previous action
    func leftBackToPrevious() {
        self.leftBackBarButton(UIImage(asset:.Back_icon), action: nil)
    }
    
    //back action
    private func leftBackBarButton(backImage: UIImage, action: ActionHandler!) {
        guard self.navigationController != nil else {
            assert(false, "Your target ViewController doesn't have a UINavigationController")
            return
        }
        
        let button: UIButton = UIButton(type: UIButtonType.Custom)
        button.setImage(backImage, forState: .Normal)
        button.frame = CGRectMake(0, 0, 40, 30)
        button.imageView!.contentMode = .ScaleAspectFit;
        button.contentHorizontalAlignment = .Left
        
        button.ngl_addAction(forControlEvents: .TouchUpInside, withCallback: {[weak self] in
            //If custom action ,call back
            if action != nil {
                action()
                return
            }
            
            if self!.navigationController!.viewControllers.count > 1 {
                self!.navigationController?.popViewControllerAnimated(true)
            } else if (self!.presentingViewController != nil) {
                self!.dismissViewControllerAnimated(true, completion: nil)
            }
            })
        
        let barButton = UIBarButtonItem(customView: button)
        let gapItem = UIBarButtonItem(barButtonSystemItem: .FixedSpace, target: nil, action: nil)
        gapItem.width = -7  //fix the space
        self.navigationItem.leftBarButtonItems = [gapItem, barButton]
    }
}
import UIKit

class TSNavigationBar: UINavigationBar {
    override init (frame: CGRect) {
        super.init(frame : frame)
        self.initContent()
    }
    
    convenience init () {
        self.init(frame:CGRect.zero)
        self.initContent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func initContent() {
        
        //Init containerView
        let containerView : UIView = UIView()
        containerView.backgroundColor = UIColor.clearColor()
        self.addSubview(containerView)
        containerView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp_top).offset(-20)
            make.left.equalTo(self.snp_left).offset(0)
            make.width.equalTo(44)
            make.height.equalTo(64)
        }
    }
}

public extension UINavigationItem {
    //left bar
    func leftButtonAction(image: UIImage, action:ActionHandler) {
        let button: UIButton = UIButton(type: UIButtonType.Custom)
        button.setImage(image, forState: .Normal)
        button.frame = CGRectMake(0, 0, 40, 30)
        button.imageView!.contentMode = .ScaleAspectFit;
        button.contentHorizontalAlignment = .Left
        button.ngl_addAction(forControlEvents: .TouchUpInside, withCallback: {
            action()
        })
        let barButton = UIBarButtonItem(customView: button)
        let gapItem = UIBarButtonItem(barButtonSystemItem: .FixedSpace, target: nil, action: nil)
        gapItem.width = -7 //fix the space
        self.leftBarButtonItems = [gapItem, barButton]
    }
    
    //right bar
    func rightButtonAction(image: UIImage, action:ActionHandler) {
        let button: UIButton = UIButton(type: UIButtonType.Custom)
        button.setImage(image, forState: .Normal)
        button.frame = CGRectMake(0, 0, 40, 30)
        button.imageView!.contentMode = .ScaleAspectFit;
        button.contentHorizontalAlignment = .Right
        button.ngl_addAction(forControlEvents: .TouchUpInside, withCallback: {
            action()
        })
        let barButton = UIBarButtonItem(customView: button)
        let gapItem = UIBarButtonItem(barButtonSystemItem: .FixedSpace, target: nil, action: nil)
        gapItem.width = -7 //fix the space
//        self.rightBarButtonItems = [gapItem, barButton]
        self.setRightBarButtonItems([gapItem, barButton], animated: true)
    }
}

/*
 Block of UIControl
 */
public class ClosureWrapper : NSObject {
    let _callback : Void -> Void
    init(callback : Void -> Void) {
        _callback = callback
    }
    
    public func invoke() {
        _callback()
    }
}

var AssociatedClosure: UInt8 = 0

extension UIControl {
    private func ngl_addAction(forControlEvents events: UIControlEvents, withCallback callback: Void -> Void) {
        let wrapper = ClosureWrapper(callback: callback)
        addTarget(wrapper, action:#selector(ClosureWrapper.invoke), forControlEvents: events)
        objc_setAssociatedObject(self, &AssociatedClosure, wrapper, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}




