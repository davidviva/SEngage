//
//  UIImageEx.swift
//  SEngage
//
//  Created by Yan Wu on 5/19/16.
//  Copyright © 2016 Avaya. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    enum Asset : String {
        // LoinView
        case Login_background = "AvayaLogoBackground"
        case Login_owl = "owl-login"
        case Login_owl_left_arm = "owl-login-arm-left"
        case Login_owl_right_arm = "owl-login-arm-right"
        case Login_owl_unhide_arm = "icon_hand"
        case Login_user_handle = "iconfont-user"
        case Login_password = "iconfont-password"
        
        // Tab bar
        case Tabbar_chat_unselected = "tabbar_mainframe"
        case Tabbar_chat_selected = "tabbar_mainframeHL"
        case Tabbar_contacts_unselected = "tabbar_contacts"
        case Tabbar_contacts_selected = "tabbar_contactsHL"
        case Tabbar_me_unselected = "tabbar_me"
        case Tabbar_me_selected = "tabbar_meHL"
        
        // Contacts part
        case Contact_cell_unpicked = "CellGreySelected"
        case Contact_cell_picked = "CellBlueSelected"
        // Team Creation new team default photo is abbar_me_unselected)
        
        // FloatView
        case FloatView_background = "MessageRightTopBg"
        case FloatView_creatTeam = "contacts_add_newmessage"
        case FloatView_addContact = "barbuttonicon_add_cube"
        
        // Chat-shareMore view
        case Sharemore_pic = "sharemore_pic"                    // picture
        case Sharemore_videovoip = "sharemore_videovoip"        // videocall
        case Sharemore_location = "sharemore_location"          // location
        case Sharemore_sight = "sharemore_sight"                // sight
        case Sharemore_video = "sharemore_video"                // camera
        case Sharemore_timeSpeak = "sharemore_wxtalk"           // voice
        case Sharemore_myfav = "sharemore_myfav"                // favorite
        case SharemorePay = "sharemorePay"                      // pay
        case Sharemore_friendcard = "sharemore_friendcard"      // friendcard
        case Sharemore_other = "sharemore_otherDown"
        case Sharemore_other_HL = "sharemore_otherDownHL"
        
        // Tool Bar
        case ToolBar_voicebtn = "ToolViewInputVoice"
        case ToolBar_voicebtn_HL = "ToolViewInputVoiceHL"
        case ToolBar_emotionbtn = "ToolViewEmotion"
        case ToolBar_emotionbtn_HL = "ToolViewEmotionHL"
        case ToolBar_morebtn = "TypeSelectorBtn_Black"
        case ToolBar_morebtn_HL = "TypeSelectorBtnHL_Black"
        case ToolBar_keyboard = "ToolViewKeyboard"
        case ToolBar_keyboard_HL = "ToolViewKeyboardHL"
        
        // Chat
        case Chat_senderBackground = "SenderTextNodeBkg"
        case Chat_senderBackground_HL = "SenderTextNodeBkgHL"
        case Chat_receiverBackground = "ReceiverTextNodeBkg"
        case Chat_receiverBackground_HL = "ReceiverTextNodeBkgHL"
        case Chat_background = "bg3"
        
        // Bar Buttons
        case Back_icon = "back_icon"
        case Barbuttonicon_add = "barbuttonicon_add"
        case Barbuttonicon_addfriends = "barbuttonicon_addfriends"
        case Barbuttonicon_back = "barbuttonicon_back"
        case Barbuttonicon_back_cube = "barbuttonicon_back_cube"
        case Barbuttonicon_call = "barbuttonicon_call"
        case Barbuttonicon_Camera = "barbuttonicon_Camera"
        case Barbuttonicon_Camera_Golden = "barbuttonicon_Camera_Golden"
        case Barbuttonicon_delete = "barbuttonicon_delete"
        case Barbuttonicon_InfoMulti = "barbuttonicon_InfoMulti"
        case Barbuttonicon_InfoSingle = "barbuttonicon_InfoSingle"
        case Barbuttonicon_Luckymoney = "barbuttonicon_Luckymoney"
        case Barbuttonicon_mini_cube = "barbuttonicon_mini_cube"
        case Barbuttonicon_more = "barbuttonicon_more"
        case Barbuttonicon_more_black = "barbuttonicon_more_black"
        case Barbuttonicon_more_cube = "barbuttonicon_more_cube"
        case Barbuttonicon_Operate = "barbuttonicon_Operate"
        case Barbuttonicon_question = "barbuttonicon_question"
        case Barbuttonicon_set = "barbuttonicon_set"
        
        var image: UIImage {
            return UIImage(asset: self)
        }
    }
    
    convenience init!(asset: Asset) {
        self.init(named: asset.rawValue)
    }
}
