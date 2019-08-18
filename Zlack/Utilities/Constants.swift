//
//  Constants.swift
//  Zlack
//
//  Created by Piteli Chan on 8/14/19.
//  Copyright © 2019 pitelichan. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success : Bool) -> ()

let BASE_URL = "https://zlack-api.herokuapp.com/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_USER_ADD = "\(BASE_URL)user/add"

let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChannel"
let TO_AVATAR_PICKER = "toAvatarPicker"

// user defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"
let HEADER = [
    "Content-Type" : "application/json; charset=utf-8"
]
