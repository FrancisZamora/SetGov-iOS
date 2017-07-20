//
//  Users.swift
//  SetGov
//
//  Created by Francis Zamora on 6/21/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import ObjectMapper
class FacebookUser: Mappable {
    var fullName: String?
    var pictureData: [FacebookImage]?
        
        required init?(map: Map){
            
        }
        
        func mapping(map: Map) {
            fullName <- map["full_name"]
            pictureData <- map["profileImage"]
        }
    }


class FacebookImage: Mappable {
    var url: String?
    
    required init?(map: Map){
            
    }
        
    func mapping(map: Map) {
        url <- map["url"]
    }
    
}

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
  //  static func createFromJson(json: JSON) -> User? {
    
    //  guard let name = json["name"].string,
      //  let date = json["date"].string else {
        // return nil
      //}
    //}























}
