//
//  AuthService.swift
//  Zlack
//
//  Created by Piteli Chan on 8/14/19.
//  Copyright © 2019 pitelichan. All rights reserved.
//

import Foundation

class AuthService {
    static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    var isLoggedIn : Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
        
    }
    var authToken : String {
        get {
            return defaults.value(forKey : TOKEN_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey : TOKEN_KEY)
        }
    }
    var userEmail : String {
        get {
            return defaults.value(forKey : USER_EMAIL) as! String
        }
        set {
            defaults.set(newValue, forKey : USER_EMAIL)
        }
    }
    
    func registerUser(email : String, password : String, completion : @escaping CompletionHandler){
        let lowerCaseEmail = email.lowercased()
        let header = [
            "Content-Type" : "application/json; charset=utf-8"
        ]
        let body : [String : Any] = [
            "email" : lowerCaseEmail,
            "password" : password
        ]
        Alamofire.request(url : URL_REGISTER, method : .post, parameters : body, encoding : JSONEncoding.default, headers : header).responseString {
            (response) in
            if response.result.error == nil {
                completion(true)
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func loginUser(email : String, password : String, completion : @escaping CompletionHandler){
        let lowerCaseEmail = email.lowercased()
        
        let body : [String: Any] = [
            "email" : lowerCaseEmail,
            "password" : password
        ]
        
        Alomofire.request(URL_LOGIN, method : .post, parameters : body, encoding : JSONEncoding.default, headers : HEADER).responseJSON {
            (response) in
            if response.result.error == nil{
//                if let json = response.result.value as? Dictionary<String, Any>{
//                    if let email = json["user"] as? String{
//                        self.userEmail = email
//                    }
//                    if let token = json["token"] as? String{
//                        self.authToken = token;
//                    }
//                }
                
                //using swiftyJSON
                guard let data = response.data else{return}
                let json = JSON(data : data)
                self.userEmail = json["user"].stringValue //stringValue is.. in case, if user : nil, stringValue will auto set ""
                self.authToken = json["token"].stringValue
                
                
                self.isLoggedIn = true;
                completion(true)
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
}
