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
        let URL = "https://setgov.herokuapp.com/api/v/1/graph"
        let query = "mutation {authenticateUser(facebook_token:\"\(token)\") {id,full_name, profileImage{ id, url}}}"
        
        Alamofire.request(URL,method: .post, parameters: ["query":query],encoding: JSONEncoding.default,headers: [:]).responseJSON { response in
            
            print(response)
            guard let jsonString = response.result.value else {
                onCompletion(JSON.null)
                return
            }
            
            let json = JSON(jsonString)
            onCompletion(json)
        }
    }
    
    
    static func addEvent(event:Event, onCompletion: @escaping(Bool) -> Void) {
        
        print("ADDING EVENT: \(event.title)")
        print("ADDING EVENT: \(event.agendaItems)")
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yy"
        formatter.dateStyle = .short
        
        //        let formattedDate = event.date + " 2017"
        //        let date = formatter.date(from: formattedDate)
        //
        //        let dateString = formatter.string(from: date!)
        
        let url = "https://setgov.herokuapp.com/api/v/1/graph"
        let query = "mutation{addEvent(name:\"\(event.title)\",city:\"\(event.city)\",address:\"\(event.address)\",date:\"\(event.date)\",description:\"\(event.description)\",time:\"\(event.time)\"){id}}"
        Alamofire.request(url,
                          method: .post,
                          parameters: ["query":query],
                          encoding: JSONEncoding.default,
                          headers: [:])
            .responseJSON { response in
                
                
                guard let jsonString = response.result.value,
                    let eventId = JSON(jsonString)["data"]["addEvent"]["id"].int else {
                        onCompletion(false)
                        return
                }
                
                print("ADD EVENT RESPONSE: \(JSON(jsonString))")
                
                addAgendaItem(eventId: eventId,
                              agendaItems: event.agendaItems,
                              onCompletion: onCompletion)
        }
    }
    
    static func addAgendaItem(eventId: Int,
                              agendaItems: [Agenda],
                              onCompletion: @escaping(Bool) -> Void) {
        
        //        let mutation = "mutation {addAgendaItem(event_id:\(eventId),agendaItem_name:\"\(itemName))\",agendaItem_type:\"\(agendaType)\",agendaItem_description:\"\(agendaDescription)\"){name,description,type}}"
        
    }
    
    static func createComment(comment:String, eventID:Int, onCompletion: @escaping(JSON) -> Void) {
        let URL = "https://setgov.herokuapp.com/api/v/1/graph"
        let query = "mutation{ addComment(text:\"\(comment)\",event_id:\(eventID)) {timestamp}}"
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
    
    static func deleteComment(commentID:Int, onCompletion: @escaping(JSON) -> Void) {
        let URL = "https://setgov.herokuapp.com/api/v/1/graph"
        let query = "mutation{ deleteComment(text:\(commentID)) {timestamp}}"
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
    
    
    static func attendEvent(eventID:Int, onCompletion: @escaping(JSON) -> Void) {
        print(eventID)
        
        let URL = "https://setgov.herokuapp.com/api/v/1/graph"
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
        let URL = "https://setgov.herokuapp.com/api/v/1/graph"
        let query = "query{ event(id:\(eventID)){id,name,address,date,time,description,attendingUsers{profileImage{url},full_name},comments{text,id, karma,timestamp,user{full_name, profileImage{url}}}}}"
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
    
    static func vote(id:Int,value:Int, onCompletion: @escaping(JSON) -> Void) {
        let URL = "https://setgov.herokuapp.com/api/v/1/graph"
        let query = "mutation{voteOnComment(comment_id:\(id), vote_value:\(value)){id}}"
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
    
    static func fetchEvents(city:String, onCompletion: @escaping([Event]) -> Void) {
        let URL = "https://setgov.herokuapp.com/api/v/1/graph"
        let query = "query { upcomingEvents(city:\"\(city)\"){id,name,date,description, attendingUsers{full_name, profileImage{url}}, address, time, city, agendaItems{name, description, type}}}"
        Alamofire.request(URL,method: .post, parameters: ["query":query],encoding: JSONEncoding.default,headers: [:]).responseJSON { response in
            guard let jsonString = response.result.value,
                let events = JSON(jsonString)["data"]["upcomingEvents"].array else {
                    onCompletion([])
                    return
            }
            
            
            print("FETCHED EVENTS: \(events)")
            
            var eventsArray = [Event]()
            for event in events {
                //print("EVENT: \(event)")
                var userArray = [User]()

                if let users = event["attendingUsers"].array {
                    for user in users {
                        if let fullName = user["full_name"].string,
                            let profileUrl = user["profileImage"]["url"].string {
                            userArray.append(User(fullName: fullName, profilePictureURL: profileUrl))
                        }
                    }
                }
                
                var agendaArray = [Agenda]()
                if let agendaItems = event["agendaItems"].array {
                    for agenda in agendaItems {
                        if let name = agenda["name"].string,
                            let description = agenda["description"].string {
                            agendaArray.append(Agenda(name: name, description: description))
                        }
                    }
                }
                
                
                if let city = event["city"].string,
                    let name = event["name"].string,
                    let id = event["id"].int,
                    let address = event["address"].string,
                    let time = event["time"].string,
                    let description = event["description"].string,
                    let date = event["date"].string {
                    eventsArray.append(Event(title: name,
                                             address: address,
                                             users: userArray,
                                             description: description,
                                             date: date,
                                             eventImageName: "bostonPark",
                                             time: time,
                                             city: city,
                                             agendaItems: agendaArray,
                                             id: id))
                }
            }
            
            
            
            
            onCompletion(eventsArray.sorted(by: { $0.realDate < $1.realDate }))
            
        }
    }
    
}
