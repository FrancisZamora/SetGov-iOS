//
//  EventDiscussion.swift
//  SetGov
//
//  Created by Francis Zamora on 3/22/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

class EventDiscussion: UITableViewCell {
    @IBOutlet var upVote: UIButton!
    @IBOutlet var downVote: UIButton!
    @IBOutlet var userPicture: ProfilePicture!
    @IBOutlet var userName: UILabel!
    @IBOutlet var timeStamp: UILabel!
    @IBOutlet var karma: UILabel!
    var upVoted = false
    var downVoted = false
    
    
    
    
    @IBAction func upvoteAction(_ sender: Any) {
    }
    
    
    

    
    
    
    @IBAction func downvoteAction(_ sender: Any) {
    }
    
    
    
    
    
    
    
    
    
}
