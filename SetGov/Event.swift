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
    var eventDate = "June 30th"
    var eventDescription = " "
    var eventImage = #imageLiteral(resourceName: "Image1")
    var eventTags = [String]()
    //var eventUsers = [String]() once facebook is linked up with SetGov, use this constructor
    
    
    
    
    init(eventTitle:String, eventDescription: String, eventDate: String, eventImageName: String, eventTags:[String]) {
        self.eventTitle = eventTitle
        self.eventDescription = " "
        self.eventDate = eventDate
        self.eventImage = UIImage(imageLiteralResourceName: eventImageName)
        self.eventTags = eventTags
        // ** read top comment self.eventUsers = eventUsers
    }
    
    
}










