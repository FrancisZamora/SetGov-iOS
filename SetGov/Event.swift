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
    var eventTitle = " "
    var eventAddress = " "
    var eventDate = "June 30th"
    var eventTime = " "

    var eventDescription = " "
    var eventImage = #imageLiteral(resourceName: "Image1")
    
    var eventTags = [String]()
    var eventUsers = [String]()
   // var loggedUser = User(userName: " " , attendingStatus: false, interestedStatus: false)
    
    
    
    
    
    init(eventTitle:String, eventAddress: String, eventUsers: [String],  eventDescription: String, eventDate: String, eventImageName: String, eventTime: String, eventTags:[String]) {
        self.eventTitle = eventTitle
        self.eventDescription = eventDescription
        self.eventUsers = eventUsers
        self.eventImage = UIImage(imageLiteralResourceName: eventImageName)
        self.eventTags = eventTags
        self.eventDate = eventDate
        self.eventTime = eventTime
        self.eventAddress = eventAddress
        
        // ** read top comment self.eventUsers = eventUsers
    }
    
    
    static func createFromJson(json: JSON) -> Event? {
        
        guard let name = json["name"].string,
            let date = json["date"].string else {
                return nil
        }
        
    }
    
}










