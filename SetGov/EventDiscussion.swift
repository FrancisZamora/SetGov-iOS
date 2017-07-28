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
    var user: User!
    
    
    
    func configure() {
        let theProfileImageUrl = URL(string:self.user.profilePictureURL)
        do {
            let imageData = try Data(contentsOf: theProfileImageUrl!)
            userPicture.image = UIImage(data: imageData)
        } catch {
            print("Unable to load data: \(error)")
        }
        
    }
    
    @IBAction func upvoteAction(_ sender: Any) {
        if self.upVoted == false {
            var x = Int(karma.text!)
            x = x! +  1
            karma.text = String(describing: x!)
            self.upVoted = true
            self.downVoted = false
        }
        
    }
    
    
    @IBAction func replyAction(_ sender: Any) {
        
        
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
