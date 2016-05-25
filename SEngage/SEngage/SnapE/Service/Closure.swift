//
//  Closure.swift
//  SnapE
//
//  Created by WangXin on 4/8/16.
//  Copyright © 2016 WangXin. All rights reserved.
//

import Foundation

struct Closure {
    typealias LoginClosure = (LoginResponse) -> Void
    typealias ContactUpdateClosure = (ContactUpdateResponse) -> Void
    typealias ConnectClosure = (ConnectResponse) -> Void
    typealias SearchContactClosure = (SearchContactResponse) -> Void
}