//
//  ButtonView.swift
//  SEngage
//
//  Created by Yan Wu on 3/28/16.
//  Copyright © 2016 Avaya. All rights reserved.
//

import UIKit

class ButtonTapGestureRecognizer: UITapGestureRecognizer {
    var buttonIndex: Int!
}

class ButtonView: UIView {
    var buttons = [UIButton]()
    var buttonWidth: CGFloat!
    weak var parentCell: ChatListBaseCell!
    var buttonSelector: Selector!
    var widthConstraint: NSLayoutConstraint!
    
    var buttonBackgroundColors: [UIColor]!
    
    let defaultButtonMargin: CGFloat = 20
    
    convenience init(buttons: Array<UIButton>, parentCell: ChatListBaseCell, buttonSelector: Selector) {
        self.init(frame: CGRectZero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        widthConstraint = NSLayoutConstraint(item: self, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 0.0)
        addConstraint(widthConstraint)
        
        self.buttons = buttons
        self.parentCell = parentCell
        self.buttonSelector = buttonSelector
        
    }
    
    func setupButton(buttons: [UIButton], buttonWidth: CGFloat = 90) {
        for button in self.buttons {
            button.removeFromSuperview()
        }
        self.buttons = buttons
        
        if buttons.count > 0 {
            var buttonIndex = 0
            var precedingView = UIView()
            for button in buttons {
                addSubview(button)
                button.translatesAutoresizingMaskIntoConstraints = false
                
                if precedingView.isKindOfClass(UIButton) {
                    addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[precedingView][button(==precedingView)]", options: .AlignAllBaseline, metrics: nil, views: ["precedingView": precedingView, "button": button]))
                } else {
                    addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[button]", options: .DirectionLeadingToTrailing, metrics: nil, views: ["button": button]))
                }
                addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[button]|", options: .DirectionLeadingToTrailing, metrics: nil, views: ["button": button]))
                
                buttonIndex += 1
                let gesture = ButtonTapGestureRecognizer(target: parentCell, action: buttonSelector)
                gesture.buttonIndex = buttonIndex
                button.addGestureRecognizer(gesture)
                precedingView = button
            }
            addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("[precedingView]|", options: .DirectionLeadingToTrailing, metrics: nil, views: ["precedingView": precedingView]))
        }
        widthConstraint.constant = buttonWidth * CGFloat(buttons.count)
        setNeedsLayout()
        
    }
    
    func pushBackgroundColor() {
        buttonBackgroundColors = [UIColor]()
        
        for button in self.buttons {
            buttonBackgroundColors.append(button.backgroundColor!)
        }
    }
    
    
    func popBackgroundColor() {
        let buttonArray = buttons as NSArray
        let e = buttonArray.objectEnumerator()
        for color in buttonBackgroundColors {
            let button = e.nextObject() as! UIButton
            button.backgroundColor = color
        }
        
        buttonBackgroundColors.removeAll()
        buttonBackgroundColors = nil
    }

}
