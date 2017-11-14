//
//  Comment.swift
//  SetGov
//
//  Created by Francis Zamora on 7/28/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation
import SwiftyJSON

class Comment {
    var commentID: Int = -1
    var text = " "
    //var parentEvent = " "
    var karma = 0
    var timeStamp = "0 mins ago"
    var user = User()
    var replies = [Comment]()
    var isReply = false
    
    init(text:String,  user:User, karma:Int,timeStamp:String,commentID:Int) {
        self.text = text
        //self.parentEvent = parentEvent
        self.karma = karma
        self.user = user
        self.timeStamp = timeStamp
        self.commentID = commentID
    }
    
    init(json: JSON) {
        
        if let commentID = json["id"].int {
            self.commentID = commentID
        }
        if let karma = json["karma"].int {
            self.karma = karma
        }
        if let text = json["text"].string {
            self.text = text
        }
        if let timeStamp = json["timestamp"].string {
            self.timeStamp = timeStamp
        }
        if let userJson = json["user"] as? JSON {
            self.user = User(json: userJson)
        }
        if let repliesJson = json["replies"].array {
            self.replies = repliesJson.map({ (r) -> Comment in
                return Comment(json: r)
            })
        }
    }
}
