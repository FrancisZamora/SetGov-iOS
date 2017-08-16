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
        
        Alamofire.request(URL,
                          method: .post,
                          parameters: ["query":query],
                          encoding: JSONEncoding.default,
                          headers: [:])
            .responseJSON { response in
            
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
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yy"
        formatter.dateStyle = .short
        
        print("add event title: \(event.title)")
        print("add event agenda: \(event.agendaItems)")
        
        let url = "https://setgov.herokuapp.com/api/v/1/graph"
        let query = "mutation{addEvent(name:\"\(event.title)\",city:\"\(event.city)\",address:\"\(event.address)\",date:\"\(event.date)\",time:\"\(event.time)\", description:\"\(event.description)\",agendaItems:\(Agenda.buildGraphString(agendaList: event.agendaItems))){id, agendaItems{ name, description, text}}}"
        Alamofire.request(url,
                          method: .post,
                          parameters: ["query":query],
                          encoding: JSONEncoding.default,
                          headers: [:])
            .responseJSON { response in
                
                print("ADD EVENT RESPONSE: \(response.result.value)")
                
                guard let jsonString = response.result.value,
                    let _ = JSON(jsonString)["data"]["addEvent"]["id"].int else {
                        
                        print("ADD EVENT ERROR")
                        
                        
                        onCompletion(false)
                        return
                }
                
                print("ADD EVENT RESPONSE: \(JSON(jsonString))")
                onCompletion(true)
                
        }
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
        let query = "mutation{ deleteComment(comment_id:\(commentID)) {timestamp}}"
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
    
    static func unattendEvent(eventID:Int, onCompletion: @escaping([User]) -> Void) {
        let URL = "https://setgov.herokuapp.com/api/v/1/graph"
        let query = "mutation {unattendEvent(event_id:\(eventID)){id,name,address,date,time,description,attendingUsers{profileImage{url},full_name},comments{text,id, karma,timestamp,user{full_name, profileImage{url}}}}}"
         Alamofire.request(URL,method: .post, parameters: ["query":query],encoding: JSONEncoding.default,headers: [:]).responseJSON { response in
        let jsonString = response.result.value
        let event = JSON(jsonString)["data"]["event"]
        let User = createUsers(event: event)
        onCompletion(User)
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
            onCompletion(json)
        }
    }
    
    static func fetchEvents(city:String, onCompletion: @escaping([Event]) -> Void) {
        let URL = "https://setgov.herokuapp.com/api/v/1/graph"
        let query = "query { upcomingEvents(city:\"\(city)\"){id,name,date,description, attendingUsers{full_name, profileImage{url}}, address, time, city, agendaItems{name, description, text}, comments{id,user{full_name,profileImage{url}},karma,timestamp,text}}}"
        Alamofire.request(URL,method: .post, parameters: ["query":query],encoding: JSONEncoding.default,headers: [:]).responseJSON { response in
            guard let jsonString = response.result.value,
                let events = JSON(jsonString)["data"]["upcomingEvents"].array else {
                    onCompletion([])
                    return
            }
            
            
            print("FETCHED EVENTS: \(events)")
            
            var eventsArray = [Event]()
            for event in events {
                
                let users = createUsers(event: event)
                let agendas = createAgendas(event: event)
                print(agendas)
                
                let comments = createComments(event: event)
                
                
                if let city = event["city"].string,
                    let name = event["name"].string,
                    let id = event["id"].int,
                    let address = event["address"].string,
                    let time = event["time"].string,
                    let description = event["description"].string,
                    let date = event["date"].string {
                    eventsArray.append(Event(title: name,
                                             address: address,
                                             users: users,
                                             description: description,
                                             date: date,
                                             eventImageName: "bostonPark",
                                             time: time,
                                             city: city,
                                             agendaItems: agendas,
                                             comments: comments,
                                             id: id))
                }
            }
            
            onCompletion(eventsArray.sorted(by: { $0.realDate < $1.realDate }))
            
        }
    }
    
    static func createUsers(event: JSON) -> [User] {
        var userArray = [User]()
        
        if let users = event["attendingUsers"].array {
            for user in users {
                if let fullName = user["full_name"].string,
                    let profileUrl = user["profileImage"]["url"].string {
                    userArray.append(User(fullName: fullName, profilePictureURL: profileUrl))
                }
            }
        }
        return userArray

    }
    
    static func createComments(event: JSON) -> [Comment] {
        var commentArray = [Comment]()
        if let comments = event["comments"].array {
            for comment in comments {
                if let text = comment["text"].string,
                    let karma = comment["karma"].int,
                    let timeStamp = comment["timestamp"].string,
                    let commentID = comment["id"].int,
                    let fullName = comment["user"]["full_name"].string,
                    let profilePictureURL = comment["user"]["profileImage"]["url"].string {
                    commentArray.append(Comment(text: text, user: User(fullName: fullName,profilePictureURL: profilePictureURL), karma: karma, timeStamp: timeStamp, commentID: commentID))
                }
            }
        }
        return commentArray
    }
    
    static func createAgendas(event: JSON) -> [Agenda] {
        print(event)
        print("creating agenda")
        var agendaArray = [Agenda]()
        if let agendaItems = event["agendaItems"].array {
            for agenda in agendaItems {
        
                let a = Agenda()
                if let name = agenda["name"].string,
                    let description = agenda["description"].string {
                    a.name = name
                    a.description = description
                }
                
                if let text = agenda["text"].string {
                    let textString = text.replacingOccurrences(of: "%^&*", with: "\n")
                    a.text = textString
                }
                agendaArray.append(a)
            }
        }
        return agendaArray
    }
    
}
