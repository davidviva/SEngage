//
//  NavigationButton.swift
//  SEngage
//
//  Created by Yan Wu on 5/11/16.
//  Copyright © 2016 Avaya. All rights reserved.
//

import UIKit

class NavigationButton: UIButton {
    
    var contentView: UIView!      // 内容页
    var controllerView: UIView! // 控制器页
    var animationTime: Double = 0.5 // 动画时长
    var arrow: UIImageView! // 箭头
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(frame: CGRect, controllerView: UIView) {
        self.init(frame: frame)
        
        // 设置内容页
        contentView = UIView()
        contentView.frame = CGRectMake(0, -UIScreen.mainScreen().bounds.height, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height)
        contentView.backgroundColor = UIColor.blueColor()
        self.addTarget(self, action: #selector(NavigationButton.buttonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.controllerView = controllerView
        self.controllerView.addSubview(contentView)
        
        
        // 设置箭头
        arrow = UIImageView()
        arrow.frame = CGRectMake((frame.width - frame.height) + frame.height/4, frame.height/4, frame.height/2, frame.height/2)
        arrow.image = UIImage(named: "NavArrow")
        self.addSubview(arrow)
    }
    
    // 按钮事件
    func buttonAction(sender: UIButton) {
        
        // 向下滑动
        if sender.selected == false {
            sender.selected = true
            controllerView.bringSubviewToFront(contentView)
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(animationTime)
            UIView.setAnimationCurve(UIViewAnimationCurve.EaseInOut)
            self.contentView.frame.origin.y = 0
            UIView.commitAnimations()
            
            // 箭头旋转
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(animationTime)
            UIView.setAnimationCurve(UIViewAnimationCurve.EaseInOut)
            self.arrow.transform = CGAffineTransformMakeRotation(180.0 * CGFloat(M_PI) /  180.0)
            UIView.commitAnimations()
            
            
            // 向上滑动
        } else if sender.selected == true {
            sender.selected = false
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(animationTime)
            UIView.setAnimationCurve(UIViewAnimationCurve.EaseInOut)
            self.contentView.frame.origin.y = -UIScreen.mainScreen().bounds.height
            UIView.commitAnimations()
            
            // 箭头旋转
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(animationTime)
            UIView.setAnimationCurve(UIViewAnimationCurve.EaseInOut)
            self.arrow.transform = CGAffineTransformMakeRotation(0 * CGFloat(M_PI) /  180.0)
            UIView.commitAnimations()
        }
    }
    
}
