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
    var fullName = " "
    var profilePictureURL = " "
    var interestedStatus = false
    var attendingStatus = false
    //pic
    
    init(fullName:String, profilePictureURL:String, interestedStatus:Bool,attendingStatus:Bool){
        self.fullName = fullName
        self.profilePictureURL = profilePictureURL
        self.attendingStatus = attendingStatus
        self.interestedStatus = interestedStatus
       
    }
  //  static func createFromJson(json: JSON) -> User? {
    
    //  guard let name = json["name"].string,
      //  let date = json["date"].string else {
        // return nil
      //}
    //}























}
