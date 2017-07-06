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
    var upVoted =  Bool()
    var downVoted = Bool()
    
    
    
    
    @IBAction func upvoteAction(_ sender: Any) {
        if self.upVoted == false {
            var x = Int(karma.text!)
            x = x! +  1
            karma.text = String(describing: x!)
            print(karma.text)
            self.upVoted = true
            self.downVoted = false
        }
        
    }
    
    
    

    
    
    
    @IBAction func downvoteAction(_ sender: Any) {
        if self.downVoted == false {
            var x = Int(karma.text!)
            x = x! -  1
            karma.text = String(describing: x!)
            self.upVoted = false
            self.downVoted = true
        }
    }
    
    
    
    
    
    
    
    
    
}
