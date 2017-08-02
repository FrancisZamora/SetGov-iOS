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
import Kingfisher
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
    var comment: Comment!
    
    @IBOutlet var textBox: UILabel!
    
    
    
    func configure(comment:Comment) {
        self.comment = comment
        textBox.text = comment.text
        karma.text = String(describing:comment.karma)
        userName.text = comment.user.fullName
        let theProfileImageUrl = URL(string:comment.user.profilePictureURL)
        do {
            let imageData = try Data(contentsOf: theProfileImageUrl!)
            
            userPicture.kf.setImage(with: theProfileImageUrl)
            print("image created")
        } catch {
            print("Unable to load data: \(error)")
            print("image failed")
        }
        
        
        
       
        
    }
    
    @IBAction func upvoteAction(_ sender: Any) {
        if UserDefaults.standard.string(forKey: comment.text) == "upvoted" {
            return
        }
       
        var x = Int(karma.text!)
        x = x! +  1
        karma.text = String(describing: x!)
        self.upVoted = true
        self.downVoted = false
        ApiClient.vote(id: self.comment.commentID, value: self.comment.karma + 1 , onCompletion:{json in })
        UserDefaults.standard.set("upvoted",forKey:comment.text)

        
        
    }
    
    
    @IBAction func replyAction(_ sender: Any) {
        
        
    }
    

    
    
    
    @IBAction func downvoteAction(_ sender: Any) {
        if UserDefaults.standard.string(forKey: comment.text) == "downvoted" {
            return
        }
        if self.downVoted == false {
            ApiClient.vote(id: self.comment.commentID, value: self.comment.karma - 1, onCompletion:{json in })
            var x = Int(karma.text!)
            x = x! -  1
            karma.text = String(describing: x!)
            self.upVoted = false
            self.downVoted = true
        }
        UserDefaults.standard.set("downvoted",forKey:comment.text)

    }
    
    
    
    
    
    
    
    
    
}
