//
//  Event.swift
//  SetGov
//
//  Created by Francis Zamora on 6/14/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import PromiseKit

class Event {
    var id: Int = -1
    var name = ""
    var address = ""
    var type = ""
    var date = ""
    var time = ""
    var description = ""
    var image = #imageLiteral(resourceName: "Image1")
    var city = ""
    var realDate = Date()
    var attendingUsers = [User]()
    var agendaItems = [Agenda]()
    var comments = [Comment]()
    var eventDate = String()
   // var loggedUser = User(userName: " " , attendingStatus: false, interestedStatus: false)
    
    init() {
        
    }
    
    init(json: JSON) {
        
        if let id = json["id"].int {
            self.id = id
        }
        if let name = json["name"].string {
            self.name = name
        }
        if let address = json["address"].string {
            self.address = address
        }
        if let type = json["type"].string {
            self.type = type
        }
        if let date = json["date"].string {
            self.date = date
        }
        if let time = json["time"].string {
            self.time = time
        }
        if let description = json["description"].string {
            self.description = description
        }
        if let city = json["city"].string {
            self.city = city
        }
        if let attendingUsersJson = json["attendingUsers"].array {
            self.attendingUsers = attendingUsersJson.map({ (user) -> User in
                return User(json: user)
            })
        }
        if let agendaItemsJson = json["agendaItems"].array {
            self.agendaItems = agendaItemsJson.map({ (a) -> Agenda in
                return Agenda(json: a)
            })
        }
        if let commentsJson = json["comments"].array {
            self.comments = commentsJson.map({ (c) -> Comment in
                return Comment(json: c)
            })
        }
    }
    
    init(type: String, title:String, address: String, users: [User],  description: String, date: String, eventImageName: String, time: String, city: String,agendaItems: [Agenda], comments: [Comment], id: Int) {
        
        self.name = title
        self.description = description
        self.attendingUsers = users
        self.image = UIImage(imageLiteralResourceName: eventImageName)
        self.date = date
        self.time = time
        self.address = address
        self.city = city
        self.agendaItems = agendaItems
        self.comments = comments
        self.id = id
        self.type = type
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
    
        if let newDate = formatter.date(from: date) {
            self.realDate = newDate
        }
        
        let eventFormatter = DateFormatter()
        eventFormatter.dateFormat = "MMM dd, yyyy"
        let eventfriendlyDate = eventFormatter.string(from:realDate)
        var eventfriendlyDateArray = eventfriendlyDate.components(separatedBy: ",")
        
        self.eventDate = eventfriendlyDateArray[0]
    }
}










