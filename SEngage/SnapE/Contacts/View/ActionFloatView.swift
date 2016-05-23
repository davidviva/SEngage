//
//  ActionFloatView.swift
//  SEngage
//
//  Created by Yan Wu on 5/19/16.
//  Copyright © 2016 Avaya. All rights reserved.
//

import RxCocoa
import UIKit
import SnapKit
import RxSwift

private let kActionViewWidth: CGFloat = 140   //container view width
private let kActionViewHeight: CGFloat = 110    //container view height
private let kActionButtonHeight: CGFloat = 44   //button height
private let kFirstButtonY: CGFloat = 12 //the first button Y value

class ActionFloatView: UIView {
    weak var delegate: ActionFloatViewDelegate?
    let disposeBag = DisposeBag()
    
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
        self.backgroundColor = UIColor.clearColor()
        let actionImages = [
            UIImage(asset:.Contacts_add_newmessage),
            UIImage(asset:.Barbuttonicon_add_cube),            ]
        
        let actionTitles = [
            "Create Teams",
            "Add Contacts",
            ]
        
        //Init containerView
        let containerView : UIView = UIView()
        containerView.backgroundColor = UIColor.blackColor()
        self.addSubview(containerView)
        containerView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp_top).offset(3)
            make.right.equalTo(self.snp_right).offset(-5)
            make.width.equalTo(kActionViewWidth)
            make.height.equalTo(kActionViewHeight)
        }
        
        //Init bgImageView 
//        let stretchInsets = UIEdgeInsetsMake(14, 6, 6, 34)
//        let bubbleMaskImage = UIImage(asset:.MessageRightTopBg).resizableImageWithCapInsets(stretchInsets, resizingMode: .Stretch)
        let bgImageView: UIImageView = UIImageView(image: UIImage(asset:.MessageRightTopBg))
        containerView.addSubview(bgImageView)
        bgImageView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(containerView)
        }
        
        //init custom buttons
        var yValue = kFirstButtonY
        for index in 0 ..< actionImages.count {
            let itemButton: UIButton = UIButton(type: .Custom)
            itemButton.backgroundColor = UIColor.clearColor()
            itemButton.titleLabel!.font = UIFont.systemFontOfSize(17)
            itemButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            itemButton.setTitleColor(UIColor.whiteColor(), forState: .Highlighted)
            itemButton.setTitle(actionTitles[index], forState: .Normal)
            itemButton.setTitle(actionTitles[index], forState: .Highlighted)
            itemButton.setImage(actionImages[index], forState: .Normal)
            itemButton.setImage(actionImages[index], forState: .Highlighted)
            itemButton.addTarget(self, action: #selector(ActionFloatView.buttonTaped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            itemButton.contentHorizontalAlignment = .Left
            itemButton.contentEdgeInsets = UIEdgeInsetsMake(0, 12, 0, 0)
            itemButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
            itemButton.tag = index
            containerView.addSubview(itemButton)
            
            itemButton.snp_makeConstraints { (make) -> Void in
                make.top.equalTo(containerView.snp_top).offset(yValue)
                make.right.equalTo(containerView.snp_right)
                make.width.equalTo(containerView.snp_width)
                make.height.equalTo(kActionButtonHeight)
            }
            yValue += kActionButtonHeight
        }
        
        //add tap to view
        let tap = UITapGestureRecognizer()
        self.addGestureRecognizer(tap)
        tap.rx_event.subscribeNext { _ in
            self.hide(true)
            }.addDisposableTo(self.disposeBag)
        
        self.hidden = true
    }
    
    func buttonTaped(sender: UIButton!) {
        guard let delegate = self.delegate else {
            self.hide(true)
            return
        }
        
        let type = ActionFloatViewItemType(rawValue:sender.tag)!
        delegate.floatViewTapItemIndex(type)
        self.hide(true)
    }
    
    /**
     Hide the float view
     
     - parameter hide: is hide
     */
    func hide(hide: Bool) {
        if hide {
            self.alpha = 1.0
            UIView.animateWithDuration(0.2 ,
                                       animations: {
                                        self.alpha = 0.0
                },
                                       completion: { finish in
                                        self.hidden = true
                                        self.alpha = 1.0
            })
        } else {
            self.alpha = 1.0
            self.hidden = false
        }
    }
    
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
}



/**
 *  TSMessageViewController Float view delegate methods
 */
protocol ActionFloatViewDelegate: class {
    /**
     Tap the item with index
     */
    func floatViewTapItemIndex(type: ActionFloatViewItemType)
}

enum ActionFloatViewItemType: Int {
    case CreateTeams = 0, AddContacts
}
