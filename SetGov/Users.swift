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
    var userId = -1
    var fullName = ""
    var profilePictureURL = ""
    
    init() {}
    
    init(fullName: String, profilePictureURL: String){
        self.fullName = fullName
        self.profilePictureURL = profilePictureURL
    }
    init(json: JSON) {
        if let userId = json["id"].int {
            self.userId = userId
        }
        if let fullName = json["full_name"].string {
            self.fullName = fullName
        }
        if let profileImage = json["profileImage"] as? JSON {
            self.profilePictureURL = profileImage["url"].string!
        }
    }
}
