//
//  ApiClient.swift
//  SetGov
//
//  Created by Francis Zamora on 7/19/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import AlamofireObjectMapper

class ApiClient {
    
    static func login(token:String,onCompletion: @escaping(JSON) -> Void) {
        let URL = "http://localhost:3000/api/v/1/graph"
        let query = "mutation {authenticateUser(facebook_token:\"\(token)\") {id,full_name, profileImage{ id, url}}}"


      //  Alamofire.request(URL,method: .post, parameters: ["query":query],encoding:JSONEncoding.default,headers: [:]).responseObject(keyPath: "data") { (response: DataResponse<FacebookUser>) in

        Alamofire.request(URL,method: .post, parameters: ["query":query],encoding: JSONEncoding.default,headers: [:]).responseJSON { response in
    
            print(response)
        guard let jsonString = response.result.value else {
            onCompletion(nil)
            return
        }
    
        let json = JSON(jsonString)
                            
        print("api client json \(json)")

        print(response)
            
            
       // let facebookUser = response.result.value
        //let facebookImage = facebookUser?.pictureData
        
       //guard let jsonString = response.result.value else {
         //   onCompletion(nil)
           // return
        //}
         
        print("api client json \(json)")
        //   guard let UserData = User.createFromJson(json: json) else {
          //   onCompletion()
           //}
        //onCompletion(json)
        onCompletion(json)
    }
        
    
    }
    
    static func addEvent(event:Event, onCompletion: @escaping(JSON) -> Void) {
        let address = event.eventAddress
        let name = event.eventTitle
        let city = event.eventCity
        let date = event.eventDate
        let time = event.eventTime
        let image = event.eventImage
        
        
        let description = event.eventDescription
        let URL = "http://localhost:3000/api/v/1/graph"
        let query = "mutation{addEvent(name:\"\(name)\",city:\"\(city)\",address:\"\(address)\",date:\"\(date)\",description:\"\(description)\",time:\"\(time)\", image_name:\"\(image)\"){id}}"
        Alamofire.request(URL,method: .post, parameters: ["query":query],encoding: JSONEncoding.default,headers: [:]).responseJSON { response in
            
            guard let jsonString = response.result.value else {
                onCompletion(nil)
                return
            }
            let json = JSON(jsonString)

           
            print(response)
            onCompletion(json)

        }
        
        
    }
    
    static func attendEvent(eventID:Int, onCompletion: @escaping(JSON) -> Void) {
        print(eventID)
        
        let URL = "http://localhost:3000/api/v/1/graph"
        let query = "mutation {attendEvent(event_id:\(eventID)){id }}"
        Alamofire.request(URL,method: .post, parameters: ["query":query],encoding: JSONEncoding.default,headers: [:]).responseJSON { response in
            guard let jsonString = response.result.value else {
                onCompletion(nil)
                return
            }
            let json = JSON(jsonString)
            

            print(response)
        }

    }
    
    static func fetchEvent(eventID:Int, onCompletion: @escaping(JSON) -> Void) {
         let URL = "http://localhost:3000/api/v/1/graph"
         let query = "query{ event(id:\(eventID)){attendingUsers{full_name,profileImage{url}}}}"
         Alamofire.request(URL,method: .post, parameters: ["query":query],encoding: JSONEncoding.default,headers: [:]).responseJSON { response in
    
            
            guard let jsonString = response.result.value else {
                onCompletion(JSON.null)
                return
            }
            let json = JSON(jsonString)
            
            
            print(response)
            onCompletion(json)
        }

    }
    
    static func fetchEvents(city:String, onCompletion: @escaping(JSON) -> Void) {
        let URL = "http://localhost:3000/api/v/1/graph"
        let query = "query { cityEvents(city:\"\(city)\" {id,name,description, attendingUsers{full_name, profileImage{url}}, address, city,}}}"
        Alamofire.request(URL,method: .post, parameters: ["query":query],encoding: JSONEncoding.default,headers: [:]).responseJSON { response in
            
            guard let jsonString = response.result.value else {
                onCompletion(nil)
                return
            }
            let json = JSON(jsonString)
            
            
            print(response)
            onCompletion(json)
            
        }
    }

       
    
    
}
