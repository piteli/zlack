 //
//  UserDataService.swift
//  Zlack
//
//  Created by Piteli Chan on 8/18/19.
//  Copyright © 2019 pitelichan. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
 
 class UserDataService {
    static let instance = UserDataService()
    
    public private(set) var id = ""
    public private(set) var avatarColor = ""
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name = ""
    
    func setUserData(id : String, color : String, avatarName : String, avatarColor : String, email : String,
                     name : String){
        self.id = id;
        self.avatarColor = avatarColor;
        self.avatarName = avatarName;
        self.email = email;
        self.name = name;
    }
    
    func setAvatarName(avatarName: String){
        self.avatarName = avatarName;
    }
    
    func returnUIColor(components : String) -> UIColor{
        let scanner = Scanner(string : components);
        let skipped = CharacterSet(charactersIn : "[], ")
        let comma = CharacterSet(charactersIn : ",")
        scanner.charactersToBeSkipped = skipped
        
        var r, g, b, a : NSString?
        scanner.scanUpToCharacters(from : comma, into: &r)
        scanner.scanUpToCharacters(from : comma, into: &g)
        scanner.scanUpToCharacters(from : comma, into: &b)
        scanner.scanUpToCharacters(from : comma, into: &a)
        
        let defaultColor = UIColor.lightGray
        guard let rUnwrapped = r else {return defaultColor}
        guard let gUnwrapped = g else {return defaultColor}
        guard let bUnwrapped = b else {return defaultColor}
        guard let aUnwrapped = a else {return defaultColor}
        
        let rFloat = CGFloat(rUnwrapped.doubleValue)
        let gFloat = CGFloat(gUnwrapped.doubleValue)
        let bFloat = CGFloat(bUnwrapped.doubleValue)
        let aFloat = CGFloat(aUnwrapped.doubleValue)
        
        let newUIColor = UIColor(red : rFloat, green : gFloat, blue : bFloat, alpha : aFloat)
        return newUIColor
    }
    
    func createUser(name : String, email : String, avatarName : String, avatarColor : String, completion : @escaping CompletionHandler){
        let lowerCaseEmail = email.lowercased();
        
        let body : [String : Any] = [
        "name" : name,
        "email" : lowerCaseEmail,
        "avatarName" : avatarName,
        "avatarColor" : avatarColor
        ]
        
        let headers = [
            "Authorization" : "Bearer \(AuthService.instance.authToken)",
            "Content-Type" : "application/json; charset=utf-8"
        ]
        
        Alamofire.request(URL_USER_ADD, method : .post, parameters : body, encoding : JSONEncoding.default, headers : headers).responseJSON{ (response) in
            
            if response.result.error == nil{
                guard let data = response.data else {return}
                let json = try! JSON(data : data)
                let id = json["_id"].stringValue
                let color = json["avatarColor"].stringValue
                let avatarName = json["avatarName"].stringValue
                let email = json["email"].stringValue
                let name = json["name"].stringValue
                
                UserDataService.instance.setUserData(id : id, color : color, avatarName : avatarName, avatarColor: color, email : email, name : name)
                completion(true)
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
            
        }
    }
 }
