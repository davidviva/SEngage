//
//  LoginViewController.swift
//  SEngage
//
//  Created by Yan Wu on 4/11/16.
//  Copyright © 2016 Avaya. All rights reserved.
//

import UIKit

// Requird information for global contacts search request
var sessionReceived: Session = Session()
var userReceived: User = User()
var token: String = ""
var sessionId: String = ""
var handle: String = ""

class LoginViewController: UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate {

    // Identify the text fields
    var txtUser:UITextField!
    var txtPwd:UITextField!
    var scrollView: UIScrollView!
    var loginButton: UIButton!
    var loginButtonPosition:CGPoint?
    
    // The distance hands to the head of owl
    var offsetLeftHand:CGFloat = 60
    
    // Identify the images (hide eye)
    var imgLeftHand:UIImageView!
    var imgRightHand:UIImageView!
    
    // Identify the images (unhide eye)
    var imgLeftHandGone:UIImageView!
    var imgRightHandGone:UIImageView!
    
    var imgLogin:UIImageView!
    
    // The status of the input area
    var showType:LoginShowType = LoginShowType.NONE
    
    // Username and password
    var username = ""
    var password = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialPanel()
        
        // Register the gesture for dismissing the keyboard
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(LoginViewController.handleTap(_:))))
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(LoginViewController.keyboardPushViewUp(_:)),
                                                         name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(LoginViewController.keyboardPullViewDown(_:)),name:
            UIKeyboardWillHideNotification, object: nil);
    }
    
    func initialPanel() {
        // Get the size of the screen
        let mainSize = UIScreen.mainScreen().bounds.size
        
        // Set the scroll view
        scrollView=UIScrollView()
        scrollView.frame=self.view.bounds
        self.view.addSubview(scrollView)
        
        // Set the background image
        let logoBackgroundViewRect:CGRect = CGRect(x: 0.0, y: 0.0 , width: mainSize.width, height:mainSize.height)
        let logoBackgroundView:UIImageView = UIImageView(frame: logoBackgroundViewRect)
        logoBackgroundView.image = UIImage(named:"AvayaLogoBackground")
        self.scrollView.addSubview(logoBackgroundView)
        
        // Get the image of owl
        imgLogin =  UIImageView(frame:CGRectMake(mainSize.width/2-211/2, 100, 211, 109))
        imgLogin.image = UIImage(named:"owl-login")
        imgLogin.layer.masksToBounds = true
        self.scrollView.addSubview(imgLogin)
        
        // left-hand （hide eye）
        let rectLeftHand = CGRectMake(61 - offsetLeftHand, 90, 40, 65)
        imgLeftHand = UIImageView(frame:rectLeftHand)
        imgLeftHand.image = UIImage(named:"owl-login-arm-left")
        imgLogin.addSubview(imgLeftHand)
        
        // right-hand (hide eye)
        let rectRightHand = CGRectMake(imgLogin.frame.size.width / 2 + 60, 90, 40, 65)
        imgRightHand = UIImageView(frame:rectRightHand)
        imgRightHand.image = UIImage(named:"owl-login-arm-right")
        imgLogin.addSubview(imgRightHand)
        
        // The frame of input area
        let vLogin =  UIView(frame:CGRectMake(15, 200, mainSize.width - 30, 160))
        vLogin.layer.borderWidth = 0.5
        vLogin.layer.borderColor = UIColor.lightGrayColor().CGColor
        vLogin.backgroundColor = UIColor.whiteColor()
        vLogin.layer.cornerRadius = 10
        self.scrollView.addSubview(vLogin)
        
        // left hand (unhide eye)
        let rectLeftHandGone = CGRectMake(mainSize.width / 2 - 100,
                                          vLogin.frame.origin.y - 22, 40, 40)
        imgLeftHandGone = UIImageView(frame:rectLeftHandGone)
        imgLeftHandGone.image = UIImage(named:"icon_hand")
        self.scrollView.addSubview(imgLeftHandGone)
        
        // right hand (unhide eye)
        let rectRightHandGone = CGRectMake(mainSize.width / 2 + 62,
                                           vLogin.frame.origin.y - 22, 40, 40)
        imgRightHandGone = UIImageView(frame:rectRightHandGone)
        imgRightHandGone.image = UIImage(named:"icon_hand")
        self.scrollView.addSubview(imgRightHandGone)
        
        // Settings for userName text field
        txtUser = UITextField(frame:CGRectMake(30, 30, vLogin.frame.size.width - 60, 44))
        txtUser.delegate = self
        txtUser.layer.cornerRadius = 10
        txtUser.layer.borderColor = UIColor.lightGrayColor().CGColor
        txtUser.layer.borderWidth = 0.5
        txtUser.placeholder = "Global Handle"
        txtUser.leftView = UIView(frame:CGRectMake(0, 0, 44, 44))
        txtUser.leftViewMode = UITextFieldViewMode.Always
        
        // Image for userName text field
        let imgUser =  UIImageView(frame:CGRectMake(11, 11, 22, 22))
        imgUser.image = UIImage(named:"iconfont-user")
        txtUser.leftView!.addSubview(imgUser)
        vLogin.addSubview(txtUser)
        
        // Settings for the password text field
        txtPwd = UITextField(frame:CGRectMake(30, 90, vLogin.frame.size.width - 60, 44))
        txtPwd.delegate = self
        txtPwd.layer.cornerRadius = 10
        txtPwd.layer.borderColor = UIColor.lightGrayColor().CGColor
        txtPwd.layer.borderWidth = 0.5
        txtPwd.placeholder = "Password"
        txtPwd.secureTextEntry = true
        txtPwd.leftView = UIView(frame:CGRectMake(0, 0, 44, 44))
        txtPwd.leftViewMode = UITextFieldViewMode.Always
        
        // Image for password text field
        let imgPwd =  UIImageView(frame:CGRectMake(11, 11, 22, 22))
        imgPwd.image = UIImage(named:"iconfont-password")
        txtPwd.leftView!.addSubview(imgPwd)
        vLogin.addSubview(txtPwd)
        
        // Add UIButton to the view
        loginButton = UIButton(frame: CGRectMake(40, 380, mainSize.width - 80, 39))
        loginButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        loginButton.backgroundColor = UIColor.whiteColor()
        loginButton.layer.cornerRadius = 10
        loginButton.setTitle("SIGN IN", forState: UIControlState.Normal)
        loginButton.setTitleColor(AppTheme.AVAYA_RED_COLOR_LIGHT, forState: UIControlState.Normal)
        loginButton.setTitleColor(AppTheme.AVAYA_GRAY_COLOR, forState: UIControlState.Highlighted)
        loginButton.titleLabel!.font = UIFont(name: "Helvetica Bold", size: 14)
        loginButton.addTarget(self, action: #selector(LoginViewController.loginAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.loginButtonPosition = loginButton.center
        self.scrollView.addSubview(loginButton)
    }
    
    // Settings for editing the text fields
    func textFieldDidBeginEditing(textField:UITextField)
    {
        // While the user is eidting the username
        if textField.isEqual(txtUser){
            if (showType != LoginShowType.PASS)
            {
                showType = LoginShowType.USER
                return
            }
            showType = LoginShowType.USER
            
            // Show the unhide eye images
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.imgLeftHand.frame = CGRectMake(
                    self.imgLeftHand.frame.origin.x - self.offsetLeftHand,
                    self.imgLeftHand.frame.origin.y + 30,
                    self.imgLeftHand.frame.size.width, self.imgLeftHand.frame.size.height)
                self.imgRightHand.frame = CGRectMake(
                    self.imgRightHand.frame.origin.x + 48,
                    self.imgRightHand.frame.origin.y + 30,
                    self.imgRightHand.frame.size.width, self.imgRightHand.frame.size.height)
                self.imgLeftHandGone.frame = CGRectMake(
                    self.imgLeftHandGone.frame.origin.x - 70,
                    self.imgLeftHandGone.frame.origin.y, 40, 40)
                self.imgRightHandGone.frame = CGRectMake(
                    self.imgRightHandGone.frame.origin.x + 30,
                    self.imgRightHandGone.frame.origin.y, 40, 40)
            })
        }
        
        // While the user is editing the password
        else if textField.isEqual(txtPwd){
            if (showType == LoginShowType.PASS)
            {
                showType = LoginShowType.PASS
                return
            }
            showType = LoginShowType.PASS
            
            // Show the hide eye images
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.imgLeftHand.frame = CGRectMake(
                    self.imgLeftHand.frame.origin.x + self.offsetLeftHand,
                    self.imgLeftHand.frame.origin.y - 30,
                    self.imgLeftHand.frame.size.width, self.imgLeftHand.frame.size.height)
                self.imgRightHand.frame = CGRectMake(
                    self.imgRightHand.frame.origin.x - 48,
                    self.imgRightHand.frame.origin.y - 30,
                    self.imgRightHand.frame.size.width, self.imgRightHand.frame.size.height)
                self.imgLeftHandGone.frame = CGRectMake(
                    self.imgLeftHandGone.frame.origin.x + 70,
                    self.imgLeftHandGone.frame.origin.y, 0, 0)
                self.imgRightHandGone.frame = CGRectMake(
                    self.imgRightHandGone.frame.origin.x - 30,
                    self.imgRightHandGone.frame.origin.y, 0, 0)
            })
        }
    }
    
    // The status of the input area
    enum LoginShowType {
        case NONE
        case USER
        case PASS
    }
    
    // Hide the keyboard when click ‘return’
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    // Hide the keyboard when click the blank
    func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .Ended {
            txtUser.resignFirstResponder()
            txtPwd.resignFirstResponder()
        }
        sender.cancelsTouchesInView = false
    }
    
    func keyboardPushViewUp(notification:NSNotification){
        if let info:NSDictionary = notification.userInfo {
            let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
            
            if let loginCenter:CGPoint = self.loginButtonPosition {
                let screenSize: CGRect = UIScreen.mainScreen().bounds
                let distance = loginCenter.y + keyboardFrame.height + 30 - screenSize.height
                
                if distance > 0 {
                    self.scrollView.setContentOffset(CGPointMake(0, loginCenter.y + keyboardFrame.height + 30 - screenSize.height), animated: true)
                }
            }
        }
    }
    func keyboardPullViewDown(notification:NSNotification){
        self.scrollView.setContentOffset(CGPointMake(0, 0), animated: true)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func loginAction(sender: UIButton) {
        self.txtUser.userInteractionEnabled = false
        self.txtPwd.userInteractionEnabled = false
        self.loginButton.enabled = false
        
        self.username = self.txtUser.text ?? ""
        self.password = self.txtPwd.text ?? ""
        self.performSegueWithIdentifier("Login", sender: self)
//        dispatch_async(reqQueue) { () -> Void in
//            tcpRequest.login(self.username, password: self.password)
//            tcpResponse.loginClosure(self.processResult)
//        }
    }
    
    // Only portrait view
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    
    func processResult(content: LoginResponse) {
        dispatch_async(dispatch_get_main_queue(), {
            if content.success {
                print("\(content)")
                userReceived = content.user
                sessionReceived = content.session
                token = sessionReceived.token
                sessionId = sessionReceived.sessionId
                handle = userReceived.username
                
                // skip with segue
                self.performSegueWithIdentifier("Login", sender: self)
//                self.skipToMainScreen()
            } else {
                self.resultLogin(content.errtype)
                self.txtUser.userInteractionEnabled = true
                self.txtPwd.userInteractionEnabled = true
                self.loginButton.enabled = true
            }
        })
    }
    
    // Error type
    func resultLogin(code: LoginResponse.ErrType) {
        switch code {
        case LoginResponse.ErrType.BadRequest:
            alertToggle("Bad request")
        case LoginResponse.ErrType.NoUser:
            alertToggle("Username is invalid!")
        case LoginResponse.ErrType.AuthenticationFailure:
            alertToggle("Password is invalid!")
        default: alertToggle("Unknown error!")
        }
    }
    
    
    // Alert for result of login
    func alertToggle(msg: String) {
        let alert = UIAlertController(title: "Error!" , message: msg, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
