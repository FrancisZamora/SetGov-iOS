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
import AlamofireObjectMapper

class ApiClient {
    
    static func login(token:String,onCompletion: @escaping(DataResponse<FacebookUser>) -> Void) {
        let URL = "http://localhost:3000/api/v/1/graph"
        let query = "mutation {authenticateUser(facebook_token:\"\(token)\") {id,full_name, profileImage{ id, url}}}"

        Alamofire.request(URL,method: .post, parameters: ["query":query],encoding:JSONEncoding.default,headers: [:]).responseObject(keyPath: "data") { (response: DataResponse<FacebookUser>) in


      //  Alamofire.request("http://localhost:3000/api/v/1/graph",method: .post, parameters: ["query":"mutation {authenticateUser(facebook_token:\"\(token)\") {id,full_name, profileImage{ id, url}}}"],encoding: JSONEncoding.default,headers: [:]).responseObject(keyPath: "data") { response in
        print(response)
        let facebookUser = response.result
        print(facebookUser)
        
        guard let jsonString = response.result.value else {
            //onCompletion(nil)
            return
        }
         
        let json = JSON(jsonString)
        print("api client json \(json)")
        //   guard let UserData = User.createFromJson(json: json) else {
          //   onCompletion()
           //}
        //onCompletion(json)
        onCompletion(jsonString as! DataResponse<FacebookUser>)
    }
        
    
    }
    
        
    
    
}
