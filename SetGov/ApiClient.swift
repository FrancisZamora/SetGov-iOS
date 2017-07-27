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
        var dater = String()
        let address = event.eventAddress
        let name = event.eventTitle
        let city = event.eventCity
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yy"
        formatter.dateStyle = .short
        var x = event.eventDate + " 2017"
        let date = formatter.date(from: x)
            print(date)
            
            let y = formatter.string(from: date!)
            print(y)
            
            dater = y
        
        let time = event.eventTime
        
        
        let description = event.eventDescription
        let URL = "http://localhost:3000/api/v/1/graph"
        let query = "mutation{addEvent(name:\"\(name)\",city:\"\(city)\",address:\"\(address)\",date:\"\(dater)\",description:\"\(description)\",time:\"\(time)\"){id}}"
        Alamofire.request(URL,method: .post, parameters: ["query":query],encoding: JSONEncoding.default,headers: [:]).responseJSON { response in
            
            guard let jsonString = response.result.value else {
                onCompletion(nil)
                return
            }
            let json = JSON(jsonString)
            print(json)
            
           
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
                onCompletion(JSON.null)
                return
            }
            let json = JSON(jsonString)
            onCompletion(json)

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
        let query = "query { upcomingEvents(city:\"\(city)\"){id,name,date, description, attendingUsers{full_name, profileImage{url}}, address, city}}"
        Alamofire.request(URL,method: .post, parameters: ["query":query],encoding: JSONEncoding.default,headers: [:]).responseJSON { response in
            guard let jsonString = response.result.value else {
                onCompletion(JSON.null)
                return
            }
            let json = JSON(jsonString)
            print(json)
            
            print(response)
            onCompletion(json)
            
        }
    }

       
    
    
}
