//
//  MessageService.swift
//  Zlack
//
//  Created by Fitri San on 25/08/2019.
//  Copyright © 2019 pitelichan. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    static let instance = MessageService()
    
    var channels = [Channel]()
    
    func findAllChannel(completion : @escaping CompletionHandler){
        Alamofire.request(URL_GETS_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else {return}
                
                //swift 3 method
                if let json = try! JSON(data : data).array {
                    for item in json{
                        let name = item["name"].stringValue
                        let channelDescription = item["description"].stringValue
                        let id = item["_id"].stringValue
                        let channel = Channel(channelTitle : name, channelDescription : channelDescription, id : id)
                        self.channels.append(channel)
                    }
                    completion(true)
                }
                
                // swift 4 method
//                do{
//                    self.channels = try JSONDecoder().decode([Channel].self, from : data)
//                }catch let error{
//                    debugPrint(error as Any)
//                }
                
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
}
