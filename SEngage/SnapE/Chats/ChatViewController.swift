//
//  ChatViewController.swift
//  SEngage
//
//  Created by Yan Wu on 3/28/16.
//  Copyright © 2016 Avaya. All rights reserved.
//

import UIKit
import AVFoundation


let toolBarMinHeight: CGFloat = 44.0
let indicatorViewH: CGFloat = 120

//let messageOutSound: SystemSoundID = {
//    var soundID: SystemSoundID = 10120
//    let soundUrl = CFBundleCopyResourceURL(CFBundleGetMainBundle(), "MessageOutgoing", "aiff", nil)
//    AudioServicesCreateSystemSoundID(soundUrl, &soundID)
//    return soundID
//}()
//
//
//let messageInSound: SystemSoundID = {
//    var soundID: SystemSoundID = 10121
//    let soundUrl = CFBundleCopyResourceURL(CFBundleGetMainBundle(), "MessageIncoming", "aiff", nil)
//    AudioServicesCreateSystemSoundID(soundUrl, &soundID)
//    return soundID
//}()

class ChatViewController: SEViewController, UITableViewDataSource, UITableViewDelegate , UITextViewDelegate {

    var tableView: UITableView!
    var toolBarView: ToolBarView!
    var emojiView: EmotionView!
    var shareView: ShareMoreView!
    var recordIndicatorView: RecordIndicatorView!
    var videoController: VideoController!
    
    var recorder: AudioRecorder!
    var player: AudioPlayer!
    var videoRecordBakgoundView: UIView!
    var videoRecordView: RecordVideoView!
    
    var messageList = [Message]()
    var toolBarConstranit: NSLayoutConstraint!
    
    // MARK: - lifecycle
    init(){
        super.init(nibName: nil, bundle: nil)
        hidesBottomBarWhenPushed = true
        title = "jamy" // change name to the contact
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // send the notifications
        scheduleNotification();
        
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bg3")!)
        
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
        tableView.registerClass(ChatVoiceCell.self, forCellReuseIdentifier: NSStringFromClass(ChatVoiceCell))
        tableView.registerClass(ChatVideoCell.self, forCellReuseIdentifier: NSStringFromClass(ChatVideoCell))
        
        view.addSubview(tableView)
        
        recordIndicatorView = RecordIndicatorView(frame: CGRectMake(self.view.center.x - indicatorViewH / 2, self.view.center.y - indicatorViewH / 3, indicatorViewH, indicatorViewH))
        
        emojiView = EmotionView(frame: CGRectMake(0, 0, view.bounds.width, 196))
        emojiView.delegate = self
        
        shareView = ShareMoreView(frame: CGRectMake(0, 0, view.bounds.width, 196), selector: #selector(ChatViewController.shareMoreClick(_:)), target: self)
        
        toolBarView = ToolBarView(taget: self, voiceSelector: #selector(ChatViewController.voiceClick(_:)), recordSelector: #selector(ChatViewController.recordClick(_:)), emotionSelector: #selector(ChatViewController.emotionClick(_:)), moreSelector: #selector(ChatViewController.moreClick(_:)))
        toolBarView.textView.delegate = self
        view.addSubview(toolBarView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        toolBarView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addConstraint(NSLayoutConstraint(item: toolBarView, attribute: .Left, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: toolBarView, attribute: .Right, relatedBy: .Equal, toItem: view, attribute: .Right, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: toolBarView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1, constant: toolBarMinHeight))
        toolBarConstranit = NSLayoutConstraint(item: toolBarView, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1, constant: 0)
        view.addConstraint(toolBarConstranit)
        
        view.addConstraint(NSLayoutConstraint(item: tableView, attribute: .Left, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: tableView, attribute: .Right, relatedBy: .Equal, toItem: view, attribute: .Right, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: tableView, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: tableView, attribute: .Bottom, relatedBy: .Equal, toItem: toolBarView, attribute: .Top, multiplier: 1, constant: 0))
        
        tableView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ChatViewController.tapTableView(_:))))
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ChatViewController.keyboardChange(_:)), name: UIKeyboardWillChangeFrameNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ChatViewController.hiddenMenuController(_:)), name: UIMenuControllerWillHideMenuNotification, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        if player != nil {
            if player.audioPlayer.playing {
                player.stopPlaying()
            }
        }
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
        
        switch message.messageType {
        case .Text:
            cell = tableView.dequeueReusableCellWithIdentifier(NSStringFromClass(ChatTextCell), forIndexPath: indexPath) as! ChatTextCell
        case .Image:
            cell = tableView.dequeueReusableCellWithIdentifier(NSStringFromClass(ChatImageCell), forIndexPath: indexPath) as! ChatImageCell
        case .Voice:
            cell = tableView.dequeueReusableCellWithIdentifier(NSStringFromClass(ChatVoiceCell), forIndexPath: indexPath) as! ChatVoiceCell
        case .Video:
            cell = tableView.dequeueReusableCellWithIdentifier(NSStringFromClass(ChatVideoCell), forIndexPath: indexPath) as! ChatVideoCell
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
            if let message = messageList[selectedIndexPath.row] as? textMessage {
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
        
        if message.messageType == .Voice {
            let message = message as! voiceMessage
            let cell = pressCell as! ChatVoiceCell
            let play = AudioPlayer()
            player = play
            player.startPlaying(message)
            cell.beginAnimation()
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(message.voiceTime.intValue) * 1000 * 1000 * 1000), dispatch_get_main_queue(), { () -> Void in
                cell.stopAnimation()
            })
        } else if message.messageType == .Video {
            let message = message as! videoMessage
            if videoController != nil {
                videoController = nil
            }
            videoController = VideoController()
            videoController.setPlayUrl(message.url)
            presentViewController(videoController, animated: true, completion: nil)
        }
    }
}

// MARK: extension for toobar action

extension ChatViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, AudioRecorderDelegate, EmotionViewDelegate, MapViewControllerDelegate {
    
    func voiceClick(button: UIButton) {
        if toolBarView.recordButton.hidden == false {
            toolBarView.showRecord(false)
        } else {
            toolBarView.showRecord(true)
            self.view.endEditing(true)
        }
    }
    
    func recordClick(button: UIButton) {
        button.setTitle("Release     to end", forState: .Normal)
        button.addTarget(self, action: #selector(ChatViewController.recordComplection(_:)), forControlEvents: .TouchUpInside)
        button.addTarget(self, action: #selector(ChatViewController.recordDragOut(_:)), forControlEvents: .TouchDragOutside)
        button.addTarget(self, action: #selector(ChatViewController.recordCancel(_:)), forControlEvents: .TouchUpOutside)
        
        let currentTime = NSDate().timeIntervalSinceReferenceDate
        let record = AudioRecorder(fileName: "\(currentTime).wav")
        record.delegate = self
        recorder = record
        recorder.startRecord()
        
        recordIndicatorView = RecordIndicatorView(frame: CGRectMake(self.view.center.x - indicatorViewH / 2, self.view.center.y - indicatorViewH / 3, indicatorViewH, indicatorViewH))
        view.addSubview(recordIndicatorView)
    }
    
    func recordComplection(button: UIButton) {
        button.setTitle("Hold     to speak", forState: .Normal)
        recorder.stopRecord()
        recorder.delegate = nil
        recordIndicatorView.removeFromSuperview()
        recordIndicatorView = nil
        
        if recorder.timeInterval != nil {
            let message = voiceMessage(incoming: false, sentDate: NSDate(), iconName: "", voicePath: recorder.recorder.url, voiceTime: recorder.timeInterval)
            let receiveMessage = voiceMessage(incoming: true, sentDate: NSDate(), iconName: "", voicePath: recorder.recorder.url, voiceTime: recorder.timeInterval)
            
            messageList.append(message)
            reloadTableView()
            messageList.append(receiveMessage)
            reloadTableView()
//            AudioServicesPlayAlertSound(messageOutSound)
        }
    }
    
    func recordDragOut(button: UIButton) {
        button.setTitle("Hold     to speak", forState: .Normal)
        recordIndicatorView.showText("Release to cancel", textColor: UIColor.redColor())
    }
    
    
    func recordCancel(button: UIButton) {
        button.setTitle("Hold     to speak", forState: .Normal)
        recorder.stopRecord()
        recorder.delegate = nil
        recordIndicatorView.removeFromSuperview()
        recordIndicatorView = nil
    }
    
    func emotionClick(button: UIButton) {
        if toolBarView.emotionButton.tag == 1 {
            toolBarView.showEmotion(true)
            toolBarView.textView.inputView = emojiView
        } else {
            toolBarView.showEmotion(false)
            toolBarView.textView.inputView = nil
        }
        toolBarView.textView.becomeFirstResponder()
        toolBarView.textView.reloadInputViews()
    }
    
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
        case .video:
            let url = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("test", ofType: "m4v")!)
            let message = videoMessage(incoming: false, sentDate: NSDate(), iconName: "", url: url)
            messageList.append(message)
            reloadTableView()
//            AudioServicesPlayAlertSound(messageOutSound)
            toolBarView.showMore(false)
            self.view.endEditing(true)
        case .location:
            let mapCtrl = MapViewController()
            mapCtrl.delegate = self
            let nav = UINavigationController(rootViewController: mapCtrl)
            self.presentViewController(nav, animated: true, completion: nil)
        case .record:
            beginVideoRecord()
        default:
            break
        }
    }
    
    func beginVideoRecord() {
        videoRecordView = RecordVideoView(frame: CGRectMake(0, view.bounds.height * 0.4, view.bounds.width, view.bounds.height * 0.6))
        videoRecordBakgoundView = UIView(frame: view.bounds)
        videoRecordBakgoundView.backgroundColor = UIColor.blackColor()
        videoRecordBakgoundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ChatViewController.videoBackgroundViewClick(_:))))
        videoRecordBakgoundView.alpha = 0.6
        videoRecordView.alpha = 1.0
        
        UIView.animateWithDuration(0.35, animations: { () -> Void in
            self.view.endEditing(true)
            self.toolBarConstranit.constant = self.videoRecordView.bounds.height
            self.scrollToBottom()
            self.view.layoutIfNeeded()
            }) { (finish) -> Void in
                self.view.addSubview(self.videoRecordBakgoundView)
                self.view.addSubview(self.videoRecordView)
        }
        
        videoRecordView.recordVideoModel.complectionClosure = { (url: NSURL) -> Void in
            let message = videoMessage(incoming: false, sentDate: NSDate(), iconName: "", url: url)
            self.messageList.append(message)
            self.reloadTableView()
//            AudioServicesPlayAlertSound(messageOutSound)
            self.toolBarView.showMore(false)
            self.videoRecordComplection()
        }
        
        videoRecordView.recordVideoModel.cancelClosure = {
            self.videoRecordComplection()
        }
    }
    
    func videoBackgroundViewClick(gestureReconizer: UITapGestureRecognizer) {
        videoRecordComplection()
    }
    
    func videoRecordComplection() {
        view.layoutIfNeeded()
        UIView.animateWithDuration(0.35, animations: { () -> Void in
            self.videoRecordBakgoundView.bounds.y = self.view.bounds.height
            self.videoRecordView.bounds.y = self.view.bounds.height
            }) { (_) -> Void in
                self.videoRecordView.removeFromSuperview()
                self.videoRecordBakgoundView.removeFromSuperview()
                self.videoRecordBakgoundView = nil
                self.videoRecordView = nil
                self.toolBarConstranit.constant = 0
                self.view.layoutIfNeeded()
        }
        toolBarView.showMore(false)
    }
    
    func sendImage(image: UIImage) {
        let message = imageMessage(incoming: false, sentDate: NSDate(), iconName: "", image: image)
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
    
    // MARK: - mapview delegate
    
    func mapViewController(controller: MapViewController, didSelectLocationSnapeShort image: UIImage) {
        toolBarView.showMore(false)
        sendImage(image)
    }
    
    func mapViewController(controller: MapViewController, didCancel error: NSError?) {
        toolBarView.showMore(false)
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
    
    // MARK: - emojiDelegate
    func selectEmoji(code: String, description: String, delete: Bool) {
        if delete {
            let range = Range(start: toolBarView.textView.text.endIndex.advancedBy(-1), end: toolBarView.textView.text.endIndex)
            toolBarView.textView.text.removeRange(range)
        } else {
            toolBarView.textView.text.appendContentsOf(code)
        }
    }
    
    // MARK: - textViewDelegate
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            let messageStr = textView.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            if messageStr.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0 {
                return true
            }
            
            let message = textMessage(incoming: false, sentDate: NSDate(), iconName: "", text: messageStr)
            let receiveMessage = textMessage(incoming: true, sentDate: NSDate(), iconName: "", text: messageStr)
            
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
    
    // MARK: -LGrecordDelegate
    func audioRecorderUpdateMetra(metra: Float) {
        if recordIndicatorView != nil {
            recordIndicatorView.updateLevelMetra(metra)
        }
    }
    
    //send the notification
    func scheduleNotification(){
        //清除所有本地推送
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        //创建UILocalNotification来进行本地消息通知
        let localNotification = UILocalNotification()
        //set the number of notifications on the app icon
        localNotification.applicationIconBadgeNumber = 78;
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }
    
    //发送通知消息
    func scheduleNotification(itemID:Int){
        //如果已存在该通知消息，则先取消
        cancelNotification(itemID)
        
        //创建UILocalNotification来进行本地消息通知
        let localNotification = UILocalNotification()
        //推送时间（设置为30秒以后）
        localNotification.fireDate = NSDate(timeIntervalSinceNow: 30)
        //时区
        localNotification.timeZone = NSTimeZone.defaultTimeZone()
        //推送内容
        localNotification.alertBody = "来自hangge.com的本地消息"
        //声音
        localNotification.soundName = UILocalNotificationDefaultSoundName
        //额外信息
        localNotification.userInfo = ["ItemID":itemID]
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }
    
    //取消通知消息
    func cancelNotification(itemID:Int){
        //通过itemID获取已有的消息推送，然后删除掉，以便重新判断
        let existingNotification = self.notificationForThisItem(itemID) as UILocalNotification?
        if existingNotification != nil {
            //如果existingNotification不为nil，就取消消息推送
            UIApplication.sharedApplication().cancelLocalNotification(existingNotification!)
        }
    }
    
    //通过遍历所有消息推送，通过itemid的对比，返回UIlocalNotification
    func notificationForThisItem(itemID:Int)-> UILocalNotification? {
        let allNotifications = UIApplication.sharedApplication().scheduledLocalNotifications
        for notification in allNotifications! {
            let info = notification.userInfo as! [String:Int]
            let number = info["ItemID"]
            if number != nil && number == itemID {
                return notification as UILocalNotification
            }
        }
        return nil
    }
}