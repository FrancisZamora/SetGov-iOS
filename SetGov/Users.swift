//
//  Users.swift
//  SetGov
//
//  Created by Francis Zamora on 6/21/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation
import UIKit

class User {
    var userName = " "
    var attendingStatus = false
    var interestedStatus = false
    var pushNotifications = true
    var homeCity = " "
    //pic
    
    init(userName:String, attendingStatus:Bool, interestedStatus:Bool,pushNotifications:Bool, homeCity:String){
        self.userName = userName
        self.attendingStatus = attendingStatus
        self.interestedStatus = interestedStatus
        self.pushNotifications = pushNotifications
        self.homeCity = homeCity
    }






















}
