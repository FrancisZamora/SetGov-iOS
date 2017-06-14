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
    var eventType = " "
    var eventDate = "June 30th"
    var eventImage = #imageLiteral(resourceName: "Image1")
    var eventTags = [String]()
    var eventUsers = [String]()
    
    
    
    
    init(eventTitle:String, eventType: String, eventDate: String, eventImageName: String, eventTags:[String], eventUsers:[String]) {
        self.eventTitle = eventTitle
        self.eventType = " "
        self.eventDate = eventDate
        self.eventImage = 
        self.eventTags = eventTags
        self.eventUsers = eventUsers
    }
    
    
}










