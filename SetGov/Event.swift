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
    var eventCity = " "
    var eventDate2 = " " 
    var eventUsers = [String]()
   // var loggedUser = User(userName: " " , attendingStatus: false, interestedStatus: false)
    
    
    
    
    
    init(eventTitle:String, eventAddress: String, eventUsers: [String],  eventDescription: String, eventDate: String, eventImageName: String, eventTime: String, eventCity: String) {
        self.eventTitle = eventTitle
        self.eventDescription = eventDescription
        self.eventUsers = eventUsers
        self.eventImage = UIImage(imageLiteralResourceName: eventImageName)
        self.eventDate = eventDate
        self.eventTime = eventTime
        self.eventAddress = eventAddress
        self.eventCity = eventCity
        // ** read top comment self.eventUsers = eventUsers
    }
    
}










