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

protocol DiscussionCallBack: class {
    func replyCommentData(comment:Comment)
}

class EventDiscussion: UITableViewCell {
    @IBOutlet var upVote: UIButton!
    @IBOutlet var downVote: UIButton!
    @IBOutlet var userPicture: ProfilePicture!
    weak var discussionCallBack: DiscussionCallBack!

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
        if UserDefaults.standard.string(forKey: String(comment.commentID)) == "upvoted" {
            var x = Int(karma.text!)
            x = x! - 1
            self.karma.text = String(describing: x!)
            ApiClient.vote(id: self.comment.commentID, value: x! , onCompletion:{json in })
            UserDefaults.standard.set("neutral",forKey:String(comment.commentID))
            return

        }
        
        if UserDefaults.standard.string(forKey: String(comment.commentID)) == "downvoted"  {
            var x = Int(karma.text!)
            x = x! + 2
            self.karma.text = String(describing: x!)
            ApiClient.vote(id: self.comment.commentID, value: x! , onCompletion:{json in })
            
            
            UserDefaults.standard.set("upvoted",forKey:String(comment.commentID))
            
            
        }
        if UserDefaults.standard.string(forKey: String(comment.commentID)) == "neutral" || UserDefaults.standard.string(forKey: String(comment.commentID)) == nil {
       
            var x = Int(karma.text!)
            x = x! +  1
            self.karma.text = String(describing: x!)
            ApiClient.vote(id: self.comment.commentID, value: x! , onCompletion:{json in })
            UserDefaults.standard.set("upvoted",forKey:String(comment.commentID))
        }
        
        
        
        
    }
    
    
    @IBAction func replyAction(_ sender: Any) {
        
        if let callback = self.discussionCallBack {
            print("callback in progress")
            
            callback.replyCommentData(comment: self.comment)
        }
        
    }
    

    
    
    
    @IBAction func downvoteAction(_ sender: Any) {
        if UserDefaults.standard.string(forKey: String(comment.commentID)) == "downvoted" {
            var x = Int(karma.text!)
            x = x! + 1
            self.karma.text = String(describing: x!)
            ApiClient.vote(id: self.comment.commentID, value: x! , onCompletion:{json in })
            UserDefaults.standard.set("neutral",forKey:String(comment.commentID))
            return
            
        }
        
        
        if UserDefaults.standard.string(forKey: String(comment.commentID)) == "upvoted" {
            var x = Int(karma.text!)
            print("this is the karma \(x)")

            x = x! -  2
            self.karma.text = String(describing: x!)
            ApiClient.vote(id: self.comment.commentID, value: x! , onCompletion:{json in })
            
          
            UserDefaults.standard.set("downvoted",forKey:String(comment.commentID))

            
        }
        if UserDefaults.standard.string(forKey: String(comment.commentID)) == "neutral" || UserDefaults.standard.string(forKey: String(comment.commentID)) == nil  {
            
            var x = Int(karma.text!)
            print("this is the karma \(x)")
            x = x! -  1
            self.karma.text = String(describing: x!)
            ApiClient.vote(id: self.comment.commentID, value: x! , onCompletion:{json in })
        
            
            UserDefaults.standard.set("downvoted",forKey:String(comment.commentID))
        }

    }
    
    
    
    
    
    
    
    
    
}
