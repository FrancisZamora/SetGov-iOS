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

class Event {
    var title = " "
    var address = " "
    var date = "June 30th"
    var time = " "

    var description = " "
    var image = #imageLiteral(resourceName: "Image1")
    var city = " "
    var realDate = Date()
    var users = [User]()
    var id: Int = -1
    var agendaItems = [Agenda]()
    var comments = [Comment]()
    var eventDate = String()
   // var loggedUser = User(userName: " " , attendingStatus: false, interestedStatus: false)
    
    
    init() {
    }
    
    
    init(title:String, address: String, users: [User],  description: String, date: String, eventImageName: String, time: String, city: String,agendaItems: [Agenda], comments: [Comment], id: Int) {
        self.title = title
        self.description = description
        self.users = users
        self.image = UIImage(imageLiteralResourceName: eventImageName)
        self.date = date
        self.time = time
        self.address = address
        self.city = city
        self.agendaItems = agendaItems
        self.comments = comments
        self.id = id
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
    
        if let newDate = formatter.date(from: date) {
            self.realDate = newDate
        }
        
        let eventFormatter = DateFormatter()
        eventFormatter.dateFormat = "MMM dd, yyyy"
        let eventfriendlyDate = eventFormatter.string(from:realDate)
        var eventfriendlyDateArray = eventfriendlyDate.components(separatedBy: ",")
        print(eventfriendlyDate)
        print(eventDate)
        
        self.eventDate = eventfriendlyDateArray[0]
        print(self.eventDate)
        print("EVENT DATE HERE")
            
        

        
        
        // ** read top comment self.eventUsers = eventUsers
    }
    
    
    
}










