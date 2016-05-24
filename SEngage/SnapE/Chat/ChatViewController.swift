//
//  ChatViewController.swift
//  SEngage
//
//  Created by Yan Wu on 5/18/16.
//  Copyright © 2016 Avaya. All rights reserved.
//

import UIKit
import AVFoundation


let toolBarMinHeight: CGFloat = 44.0
let indicatorViewH: CGFloat = 120

class ChatViewController: SEViewController, UITableViewDataSource, UITableViewDelegate , UITextViewDelegate {
    
    var tableView: UITableView!
    var toolBarView: ToolBarView!
    var shareView: ShareMoreView!
    var messageList = [MessageModel]()
    var toolBarConstranit: NSLayoutConstraint!
    var contact: Contact?
    var user: UserObj?
    
    // MARK: - lifecycle
    init(){
        super.init(nibName: nil, bundle: nil)
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = contact!.name
        user = GenerateData.generateUser()
        
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bg3")!)
        
        initTableView()
        initToolBarView()
        
        shareView = ShareMoreView(frame: CGRectMake(0, 0, view.bounds.width, 196), selector: #selector(ChatViewController.shareMoreClick(_:)), target: self)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ChatViewController.keyboardChange(_:)), name: UIKeyboardWillChangeFrameNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ChatViewController.hiddenMenuController(_:)), name: UIMenuControllerWillHideMenuNotification, object: nil)
    }
    
    func initTableView() {
        tableView = UITableView()
        tableView.backgroundColor = UIColor.clearColor()
        tableView.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
        tableView.delegate = self
        tableView.dataSource  = self
        tableView.estimatedRowHeight = 44.0
        tableView.contentInset = UIEdgeInsetsMake(0, 0, toolBarMinHeight / 2, 0)
        tableView.separatorStyle = .None
        
        tableView.registerClass(ChatImageCell.self, forCellReuseIdentifier: NSStringFromClass(ChatImageCell))
        tableView.registerClass(ChatTextCell.self, forCellReuseIdentifier: NSStringFromClass(ChatTextCell))
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addConstraint(NSLayoutConstraint(item: tableView, attribute: .Left, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: tableView, attribute: .Right, relatedBy: .Equal, toItem: view, attribute: .Right, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: tableView, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1, constant: 0))
        
        tableView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ChatViewController.tapTableView(_:))))
    }
    
    func initToolBarView() {
        toolBarView = ToolBarView(taget: self, moreSelector: #selector(ChatViewController.moreClick(_:)))
        toolBarView.textView.delegate = self
        view.addSubview(toolBarView)
        
        toolBarView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addConstraint(NSLayoutConstraint(item: toolBarView, attribute: .Left, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: toolBarView, attribute: .Right, relatedBy: .Equal, toItem: view, attribute: .Right, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: toolBarView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1, constant: toolBarMinHeight))
        toolBarConstranit = NSLayoutConstraint(item: toolBarView, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1, constant: 0)
        view.addConstraint(toolBarConstranit)
        view.addConstraint(NSLayoutConstraint(item: tableView, attribute: .Bottom, relatedBy: .Equal, toItem: toolBarView, attribute: .Top, multiplier: 1, constant: 0))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // show menuController
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    // MARK: - tableView dataSource/Delegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageList.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: ChatBaseCell
        
        let message = messageList[indexPath.row]
        
        switch message.messageContentType {
        case .Text:
            cell = tableView.dequeueReusableCellWithIdentifier(NSStringFromClass(ChatTextCell), forIndexPath: indexPath) as! ChatTextCell
        case .Image:
            cell = tableView.dequeueReusableCellWithIdentifier(NSStringFromClass(ChatImageCell), forIndexPath: indexPath) as! ChatImageCell
        }
        
        // add gustureRecognizer to show menu items
        let action: Selector = #selector(ChatViewController.showMenuAction(_:))
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: action)
        doubleTapGesture.numberOfTapsRequired = 2
        cell.backgroundImageView.addGestureRecognizer(doubleTapGesture)
        cell.backgroundImageView.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: action))
        cell.backgroundImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ChatViewController.clickCellAction(_:))))
        
        if indexPath.row > 0 {
            let preMessage = messageList[indexPath.row - 1]
            if preMessage.dataString == message.dataString {
                cell.timeLabel.hidden = true
            } else {
                cell.timeLabel.hidden = false
            }
        }
        
        cell.setMessage(message)
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil
    }
    
    func scrollToBottom() {
        let numberOfRows = tableView.numberOfRowsInSection(0)
        if numberOfRows > 0 {
            tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: numberOfRows - 1, inSection: 0), atScrollPosition: .Bottom, animated: true)
        }
    }
    
    func reloadTableView() {
        let count = messageList.count
        tableView.beginUpdates()
        tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: count - 1, inSection: 0)], withRowAnimation: .Top)
        tableView.endUpdates()
        scrollToBottom()
    }
    
    // MARK: scrollview delegate
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if velocity.y > 2.0 {
            scrollToBottom()
            self.toolBarView.textView.becomeFirstResponder()
        } else if velocity.y < -0.1 {
            self.toolBarView.textView.resignFirstResponder()
        }
    }
    
    // MARK: - keyBoard notification
    func keyboardChange(notification: NSNotification) {
        let userInfo = notification.userInfo as NSDictionary!
        let newFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let animationTimer = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        
        view.layoutIfNeeded()
        if newFrame.origin.y == UIScreen.mainScreen().bounds.size.height {
            UIView.animateWithDuration(animationTimer, animations: { () -> Void in
                self.toolBarConstranit.constant = 0
                self.view.layoutIfNeeded()
            })
        } else {
            UIView.animateWithDuration(animationTimer, animations: { () -> Void in
                self.toolBarConstranit.constant = -newFrame.size.height
                self.scrollToBottom()
                self.view.layoutIfNeeded()
            })
        }
    }
    
    // MARK: - menu actions
    
    func showMenuAction(gestureRecognizer: UITapGestureRecognizer) {
        let twoTaps = (gestureRecognizer.numberOfTapsRequired == 2)
        let doubleTap = (twoTaps && gestureRecognizer.state == .Ended)
        let longPress = (!twoTaps && gestureRecognizer.state == .Began)
        
        if doubleTap || longPress {
            let pressIndexPath = tableView.indexPathForRowAtPoint(gestureRecognizer.locationInView(tableView))!
            tableView.selectRowAtIndexPath(pressIndexPath, animated: false, scrollPosition: .None)
            
            let menuController = UIMenuController.sharedMenuController()
            let localImageView = gestureRecognizer.view!
            
            menuController.setTargetRect(localImageView.frame, inView: localImageView.superview!)
            menuController.menuItems = [UIMenuItem(title: "Copy", action: #selector(ChatViewController.copyAction(_:))), UIMenuItem(title: "Forward", action: #selector(ChatViewController.transtionAction(_:))), UIMenuItem(title: "Delete", action: #selector(ChatViewController.deleteAction(_:))), UIMenuItem(title: "More", action: #selector(ChatViewController.moreAciton(_:)))]
            
            menuController.setMenuVisible(true, animated: true)
        }
    }
    
    func copyAction(menuController: UIMenuController) {
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            if let message = messageList[selectedIndexPath.row] as? TextMessageModel {
                UIPasteboard.generalPasteboard().string = message.text
            }
        }
    }
    
    func transtionAction(menuController: UIMenuController) {
        NSLog("Forward")
    }
    
    func deleteAction(menuController: UIMenuController) {
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            messageList.removeAtIndex(selectedIndexPath.row)
            tableView.reloadData()
        }
    }
    
    func moreAciton(menuController: UIMenuController) {
        NSLog("click more")
    }
    
    func hiddenMenuController(notifiacation: NSNotification) {
        if let selectedIndexpath = tableView.indexPathForSelectedRow {
            tableView.deselectRowAtIndexPath(selectedIndexpath, animated: false)
        }
        (notifiacation.object as! UIMenuController).menuItems = nil
    }
    
    // MARK: - gestureRecognizer
    func tapTableView(gestureRecognizer: UITapGestureRecognizer) {
        self.view.endEditing(true)
        toolBarConstranit.constant = 0
        toolBarView.showEmotion(false)
        toolBarView.showMore(false)
    }
    
    func clickCellAction(gestureRecognizer: UITapGestureRecognizer) {
        let pressIndexPath = tableView.indexPathForRowAtPoint(gestureRecognizer.locationInView(tableView))!
        let pressCell = tableView.cellForRowAtIndexPath(pressIndexPath)
        let message = messageList[pressIndexPath.row]
    }
}

// MARK: extension for toobar action

extension ChatViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func moreClick(button: UIButton) {
        if toolBarView.moreButton.tag == 2 {
            toolBarView.showMore(true)
            toolBarView.textView.inputView = shareView
        } else {
            toolBarView.showMore(false)
            toolBarView.textView.inputView = nil
        }
        
        toolBarView.textView.becomeFirstResponder()
        toolBarView.textView.reloadInputViews()
    }
    
    // shareMore click
    
    func shareMoreClick(button: UIButton) {
        let shareType = shareMoreType(rawValue: button.tag)!
        
        switch shareType {
            /*
             case .picture:
             let imagePick = ImagePickController()
             imagePick.delegate = self
             let nav = UINavigationController(rootViewController: imagePick)
             self.presentViewController(nav, animated: true, completion: nil)
             */
        default:
            break
        }
    }

    
    func sendImage(image: UIImage) {
        let message = ImageMessageModel(incoming: false, sentDate: NSDate(), contact: contact!, user: user!, image: image)
        messageList.append(message)
        //        AudioServicesPlayAlertSound(messageOutSound)
        reloadTableView()
    }
    
    // MARK: - UIImagePick delegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        toolBarView.showMore(false)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        toolBarView.showMore(false)
        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    /*
     // MARK: - imagePick delegate
     func imagePickerController(picker: ImagePickController, didFinishPickingImages images: [UIImage]) {
     toolBarView.showMore(false)
     for image in images {
     sendImage(image)
     }
     }
     
     func imagePickerControllerCanceled(picker: ImagePickController) {
     toolBarView.showMore(false)
     }
     */
    
    // MARK: - textViewDelegate
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            let messageStr = textView.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            if messageStr.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0 {
                return true
            }
            
            let message = TextMessageModel(incoming: false, sentDate: NSDate(), contact: contact!, user: user!, text: messageStr)
            let receiveMessage = TextMessageModel(incoming: true, sentDate: NSDate(), contact: contact!, user: user!, text: messageStr)
            
            messageList.append(message)
            reloadTableView()
            messageList.append(receiveMessage)
            reloadTableView()
            //            AudioServicesPlayAlertSound(messageOutSound)
            textView.text = ""
            return false
        }
        return true
    }
}
