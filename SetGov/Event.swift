//
//  Event.swift
//  SetGov
//
//  Created by Francis Zamora on 6/14/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation
import UIKit

class Event {
    var eventTitle = " "
    var eventAddress = " "
    var eventDate = "June 30th"
    var eventTime = " "

    var eventDescription = " "
    var eventImage = #imageLiteral(resourceName: "Image1")
    
    var eventTags = [String]()
    var eventUser = String()
    var eventUsers = [String]()
    
    
    
    
    
    init(eventTitle:String, eventAddress: String, eventUser: String,  eventDescription: String, eventDate: String, eventImageName: String, eventTags:[String]) {
        self.eventTitle = eventTitle
        self.eventDescription = " "
        self.eventDate = eventDate
        self.eventImage = UIImage(imageLiteralResourceName: eventImageName)
        self.eventTags = eventTags
        self.eventDate = eventDate
        self.eventTime = eventTime
        self.eventUser = eventUser
        self.eventAddress = eventAddress
        
        // ** read top comment self.eventUsers = eventUsers
    }
    
    
}










