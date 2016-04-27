//
//  LocalDBService.swift
//  SEngage
//
//  Created by Yan Wu on 4/25/16.
//  Copyright © 2016 Avaya. All rights reserved.
//

import Foundation
import RealmSwift

class LocalDBService {
    var userProfile: UserObj?
    var realmObj: Realm!
    var curContactVer = 0
    var curAvatarVer = 0
    var curTeamVer = 0
    
    init() {
        realmObj = try! Realm()
    }
    
    /*
     User Profile
     RETURN:
     User profile status, whether needs update --->
     return (avatarHasChanged, contactHasChanged, teamHasChanged)
     */
    func userProfileUpdate(profileOnline: User) -> (Bool, Bool, Bool){
        let userResultSet: Results = self.realmObj.objects(UserObj).filter("username = '\(profileOnline.username)'")
        
        if userResultSet.count == 1{
            self.userProfile = userResultSet.first!
        } else if userResultSet.count == 0 {
            self.userProfile = UserObj()
            self.userProfile!.username = profileOnline.username
            self.userProfile!.email = profileOnline.email
            self.userProfile!.displayname = profileOnline.displayname
            self.userProfile!.extension_ = profileOnline.extension_
            self.userProfile!.aacParticipantPin = profileOnline.aacParticipantPin
            self.userProfile!.aacModeratorPin = profileOnline.aacModeratorPin
            self.userProfile!.avatarVer = 0
            self.userProfile!.contactVer = 0
            self.userProfile!.teamVer = 0
            self.userProfile!.cellPhone = profileOnline.cellPhone
            
            self.userProfile!.avatar = [UInt8]()
            self.userProfile!.contacts = List<ContactObj>()
            
            try! realmObj.write() {
                realmObj.add(self.userProfile!)
            }
        }
        
        var flagC: Bool = false
        var flagA: Bool = false
        var flagT: Bool = false
        
        if self.userProfile!.avatarVer != Int(profileOnline.avatarVer) {
            flagA = true
        }
        
        if self.userProfile!.contactVer != Int(profileOnline.contactVer) {
            print("not equaled")
            flagC = true
            tcpResponse.ContactUpdateClosure(self.userContactsUpdate)
        }
        
        if self.userProfile!.teamVer != Int(profileOnline.teamVer) {
            flagT = true
        }
        
        self.curTeamVer = Int(profileOnline.teamVer)
        self.curAvatarVer = Int(profileOnline.avatarVer)
        self.curContactVer = Int(profileOnline.contactVer)
        return (flagC, flagA, flagT)
    }
    
    func userContactsUpdate(content: ContactUpdateResponse) {
        let contactsOnline: Array<User> = content.contacts
        self.userProfile!.contacts = List<ContactObj>()
        print("UserContactUpdate Start!")
        self.processContactsUpdate(contactsOnline, contactVer: self.curContactVer)
    }
    
    func processContactsUpdate(contactsOnline: Array<User>, contactVer: Int) {
        self.realmObj.beginWrite()
        self.userProfile!.contactVer = contactVer
        for contact in contactsOnline {
            self.userProfile!.contacts.append(self.addSingleContact(contact))
        }
        
        self.realmObj.create(UserObj.self, value: ["username": self.userProfile!.username, "contactVer": self.userProfile!.contactVer, "contacts": self.userProfile!.contacts], update: true)
        try! self.realmObj.commitWrite()
    }
    
    func addSingleContact(newContact: User) -> ContactObj {
        var newContactObj: ContactObj = ContactObj()
        let userResultSet: Results = self.realmObj.objects(ContactObj).filter("username = '\(newContact.username)'")
        if userResultSet.count == 0 {
            newContactObj.username = newContact.username
            newContactObj.email = newContact.email
            newContactObj.displayname = newContact.displayname
            newContactObj.extension_ = newContact.extension_
            newContactObj.aacParticipantPin = newContact.aacParticipantPin
            newContactObj.aacModeratorPin = newContact.aacModeratorPin
            newContactObj.cellPhone = newContact.cellPhone
            newContactObj.avatarVer = Int(newContact.avatarVer)
            
            newContactObj.avatar = [UInt8]()
            
            self.realmObj.add(newContactObj)
            
            
        } else {
            newContactObj = userResultSet.first!
        }
        return newContactObj
    }
    
    func isExisted(single: String) -> Bool {
        for contact in self.userProfile!.contacts {
            if contact.username == single {
                return true
            }
        }
        return false
    }
    
    func getLocalContacts(username: String) -> List<ContactObj> {
        var result = List<ContactObj>()
        let userResultSet: Results = self.realmObj.objects(UserObj).filter("username = '\(username)'")
        if userResultSet.count > 0 {
            result = userResultSet.first!.contacts
        }
        
        return result
    }
}