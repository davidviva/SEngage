//
//  ChatListCellModel.swift
//  SEngage
//
//  Created by Yan Wu on 3/28/16.
//  Copyright © 2016 Avaya. All rights reserved.
//

import Foundation

class ChatListCellModel {
    let iconName: Observable<String>
    let userName: Observable<String>
    let lastMessage: Observable<String>
    let timer: Observable<String>
    
    private let emptyString = ""
    
    init() {
        iconName = Observable(emptyString)
        userName = Observable(emptyString)
        lastMessage = Observable(emptyString)
        timer = Observable(emptyString)
    }
}