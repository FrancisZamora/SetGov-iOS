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
import PromiseKit

class ApiClient {
    
    static let url = "https://setgov.herokuapp.com/api/v/1/graph"
    
    static func addEvent(event:Event, onCompletion: @escaping(Bool) -> Void) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yy"
        formatter.dateStyle = .short
        
        //print("add event title: \(name)")
        //print("add event agenda: \(event.agendaItems)")
        
        let query = "mutation{addEvent(name:\"\(event.name)\",city:\"\(event.city)\",address:\"\(event.address)\",date:\"\(event.date)\",time:\"\(event.time)\", description:\"\(event.description)\",agendaItems:\(Agenda.buildGraphString(agendaList: event.agendaItems))){id, agendaItems{ name, description, text}}}"
        Alamofire.request(url,
                          method: .post,
                          parameters: ["query":query],
                          encoding: JSONEncoding.default,
                          headers: [:])
            .responseJSON { response in
                
                //print("ADD EVENT RESPONSE: \(response.result.value)")
                
                guard let jsonString = response.result.value,
                    let _ = JSON(jsonString)["data"]["addEvent"]["id"].int else {
                        
                        //print("ADD EVENT ERROR")
                        
                        
                        onCompletion(false)
                        return
                }
                
                //print("ADD EVENT RESPONSE: \(JSON(jsonString))")
                onCompletion(true)
                
        }
    }
    
    static func attendEvent(eventID:Int, onCompletion: @escaping(JSON) -> Void) {
        //print(eventID)
        
        let URL = "https://setgov.herokuapp.com/api/v/1/graph"
        let query = "mutation {attendEvent(event_id:\(eventID)){id }}"
        Alamofire.request(URL,method: .post, parameters: ["query":query],encoding: JSONEncoding.default,headers: [:]).responseJSON { response in
            guard let jsonString = response.result.value else {
                onCompletion(JSON.null)
                return
            }
            let json = JSON(jsonString)
            onCompletion(json)
            
            //print(response)
        }
        
    }
    
    static func createAgendas(event: JSON) -> [Agenda] {
        //print(event)
        //print("creating agenda")
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
    
    static func createComment(comment:String, eventID:Int, onCompletion: @escaping(JSON) -> Void) {
        let query = "mutation{ addComment(text:\"\(comment)\",event_id:\(eventID)) {timestamp}}"
        Alamofire.request(url,method: .post, parameters: ["query":query],encoding: JSONEncoding.default,headers: [:]).responseJSON { response in
            guard let jsonString = response.result.value else {
                onCompletion(JSON.null)
                return
            }
            let json = JSON(jsonString)
            onCompletion(json)
            
            //print(response)
        }
        
    }
    
    static func createReply(comment: String, eventId: Int, replyCommentId: Int) -> Promise<JSON> {
        let mutation = GraphFactory.createGraphString(
            type: .mutation,
            action: "addReply",
            parameters: [
                "text": comment,
                "event_id": eventId,
                "parent_comment_id": replyCommentId
            ],
            properties: ["id"]
        )
        
        return graphCall(query: mutation)
            .then { json in
                guard let responseJson = json["addReply"] as? JSON else {
                    return Promise { f, r in
                        r("json not found")
                    }
                }
                return Promise { f, r in
                    f(responseJson)
                }
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
            
            //print(response)
        }
    }
    
    static func fetchCities() -> Promise<[City]> {
        print("fetch cities")
        let query = GraphFactory.createGraphString(type: .query,
                                                   action: "availableCities",
                                                   parameters: [:],
                                                   properties: ["name","state","isActive"])
        
        return graphCall(query: query)
            .then { json in
                City.createCitiesFromJson(json: json)
        }
    }
    
    static func fetchEvent(eventID:Int) -> Promise<Event> {
        let URL = "https://setgov.herokuapp.com/api/v/1/graph"
        
        let query = GraphFactory.createGraphString(
            type: .query,
            action: "event",
            parameters: [
                "id": eventID
            ],
            properties: ["id","name","agenda_link","address","type","date","time","description","attendingUsers{id,profileImage{url},full_name}","comments{text,id, karma,timestamp,user{id,full_name, profileImage{url}},replies{text,id,karma,timestamp,user{id,full_name,profileImage{url}}}}"]
        )
        
        return graphCall(query: query)
            .then { json in
                guard let eventJson = json["event"] as? JSON else {
                    return Promise { f, r in
                        r("json not found")
                    }
                }
                return Promise { f, r in
                    f(Event(json: eventJson))
                }
        }
    }
    
    static func fetchEvents(city:String, onCompletion: @escaping([Event]) -> Void) {
        let URL = "https://setgov.herokuapp.com/api/v/1/graph"
        let query = "query { upcomingEvents(city:\"\(city)\"){id,name,agenda_link,type,date,description, attendingUsers{full_name, profileImage{url}}, address, time, city, comments{id,user{full_name,profileImage{url}},karma,timestamp,text}}}"
        Alamofire.request(URL,method: .post, parameters: ["query":query],encoding: JSONEncoding.default,headers: [:]).responseJSON { response in
            
            print("FETCH EVENTS RESPONSE: \(response.result.value)")
            guard let jsonString = response.result.value,
                let events = JSON(jsonString)["data"]["upcomingEvents"].array else {
                    print("FETCH EVENTS GUARD")
                    onCompletion([])
                    return
            }
            
            print("FETCHED EVENTS: \(events)")
            
            var eventsArray = [Event]()
            for event in events {
                print("GOT EVENT: \(event)")
                let users = createUsers(event: event)
                let agendas = createAgendas(event: event)
                //print(agendas)
                
                let comments = createComments(event: event)
                
                var type = ""
                if let t = event["type"].string {
                    type = t
                }
                
                var description = ""
                if let d = event["description"].string {
                    description = d
                }
                
                var agendaLink = ""
                if let link = event["agenda_link"].string {
                    agendaLink = link
                }
                
                if let city = event["city"].string,
                    let name = event["name"].string,
                    let id = event["id"].int,
                    let address = event["address"].string,
                    let time = event["time"].string,
                    let date = event["date"].string {
                    eventsArray.append(Event(type: type,
                                             title: name,
                                             address: address,
                                             users: users,
                                             description: description,
                                             date: date,
                                             eventImageName: "bostonPark",
                                             time: time,
                                             city: city,
                                             agendaItems: agendas,
                                             comments: comments,
                                             id: id,
                                             agendaLink: agendaLink))
                }
            }
            
            onCompletion(eventsArray.sorted(by: { $0.realDate < $1.realDate }))
            
        }
    }
    
    static func graphCall(query: String) -> Promise<JSON> {
        
        return Alamofire
            .request(
                url,
                method: .post,
                parameters: ["query":query],
                encoding: JSONEncoding.default,
                headers: [:])
            .responseJSON()
            .then { json  in
                GeneralHelper.createJson(json: json)
            }.catch(execute: { (error) in
                print("graph Error: \(error)")
            })
    }
    
    static func login(token:String,onCompletion: @escaping(JSON) -> Void) {
        let query = "mutation {authenticateUser(facebook_token:\"\(token)\") {id,full_name, profileImage{ id, url}}}"
        
        Alamofire.request(url,
                          method: .post,
                          parameters: ["query":query],
                          encoding: JSONEncoding.default,
                          headers: [:])
            .responseJSON { response in
                
                //print(response)
                guard let jsonString = response.result.value else {
                    onCompletion(JSON.null)
                    return
                }
                
                let json = JSON(jsonString)
                onCompletion(json)
        }
    }
    
    static func logout(onCompletion: @escaping(JSON) -> Void) {
        let query = "mutation {logoutUser}"
        
        Alamofire.request(url,
                          method: .post,
                          parameters: ["query":query],
                          encoding: JSONEncoding.default,
                          headers: [:])
            .responseJSON { response in
                
                //print(response)
                guard let jsonString = response.result.value else {
                    onCompletion(JSON.null)
                    return
                }
                
                let json = JSON(jsonString)
                onCompletion(json)
        }
    }
    
    static func setHomeCity(city: String) {
        
        let url = "https://setgov.herokuapp.com/api/v/1/graph"
        let mutation = "mutation{setHomeCity(home_city:\"\(city)\"){id}}"
        
        Alamofire.request(url,
                          method: .post,
                          parameters: ["query":mutation],
                          encoding: JSONEncoding.default,
                          headers: [:])
            .responseJSON { _ in
                //print("SET HOME CITY RESPONSE!")
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

}
