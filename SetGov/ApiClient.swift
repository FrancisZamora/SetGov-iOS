//
//  ApiClient.swift
//  SetGov
//
//  Created by Francis Zamora on 7/19/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ApiClient {
    
    static func login(token:String,onCompletion: @escaping(JSON) -> Void) {
        
    Alamofire.request("http://localhost:3000/api/v/1/graph",
    method: .post,
    parameters: ["query":"mutation {authenticateUser(facebook_token:\"\(token)\") {id,first_name,last_name, profileImage{ id, url}}}"],encoding: JSONEncoding.default,headers: [:]).responseJSON { response in
        print(response)
        guard let jsonString = response.result.value else {
            onCompletion("error")
            return
        }
         
        let json = JSON(jsonString)
        print("api client json \(json)")
        //   guard let UserData = User.createFromJson(json: json) else {
          //   onCompletion()
           //}
        //onCompletion(json)
        onCompletion(json)
    }
        
    
    }
    
        
    
    
}
