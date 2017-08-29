//
//  Comment.swift
//  SetGov
//
//  Created by Francis Zamora on 7/28/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation

class Comment {
    var text = " "
    //var parentEvent = " "
    var karma = 0
    var timeStamp = "0 mins ago"
    var user: User
    var commentID: Int
    
    init(text:String,  user:User, karma:Int,timeStamp:String,commentID:Int) {
        self.text = text
       // self.parentEvent = parentEvent
        self.karma = karma
        self.user = user
        self.timeStamp = timeStamp
        self.commentID = commentID
    }
}
