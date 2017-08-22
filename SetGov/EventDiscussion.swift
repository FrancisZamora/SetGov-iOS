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
    func removeComment(comment:Comment)
    func displayAlert()
}

class EventDiscussion: UITableViewCell {
    @IBOutlet var upVote: UIButton!
    @IBOutlet var downVote: UIButton!
    @IBOutlet var userPicture: ProfilePicture!
    weak var discussionCallBack: DiscussionCallBack!

    @IBOutlet var userName: UILabel!
    @IBOutlet var timeStamp: UILabel!
    @IBOutlet var karma: UILabel!
    var user: User!
    var comment: Comment!
    
    @IBOutlet var textBox: UILabel!
    
    
    
    func configure(comment:Comment) {
        self.comment = comment
        textBox.text = comment.text
        textBox.lineBreakMode = .byWordWrapping
        textBox.numberOfLines = 0
        textBox.minimumScaleFactor = 0.6
        textBox.sizeToFit()
        
        karma.text = String(describing:comment.karma)
        userName.text = comment.user.fullName
        let theProfileImageUrl = URL(string:comment.user.profilePictureURL)
        do {
            
            userPicture.kf.setImage(with: theProfileImageUrl)
            print("image created")
        } catch {
            print("Unable to load data: \(error)")
            print("image failed")
        }
        
        
        
       
        
    }
    @IBAction func flagComment(_ sender: Any) {
        if let callback = self.discussionCallBack {
            print("callback in progress")
            
            callback.displayAlert()
        }
       

    }
    
    @IBAction func deleteComment(_ sender: Any) {
        if let callback = self.discussionCallBack {
            print("callback in progress")
            
            callback.removeComment(comment: self.comment)
        }
      
    }
    @IBAction func upvoteAction(_ sender: Any) {
        if UserDefaults.standard.string(forKey: String(comment.commentID)) == "upvoted" {
            var x = Int(karma.text!)
            x = x! - 1
            self.karma.text = String(describing: x!)
            ApiClient.vote(id: self.comment.commentID, value: x! , onCompletion:{json in })
            
            self.upVote.setImage(#imageLiteral(resourceName: "Image-16"), for: .normal)
            UserDefaults.standard.set("neutral",forKey:String(comment.commentID))
            return

        }
        
        if UserDefaults.standard.string(forKey: String(comment.commentID)) == "downvoted"  {
            var x = Int(karma.text!)
            x = x! + 2
            self.karma.text = String(describing: x!)
            ApiClient.vote(id: self.comment.commentID, value: x! , onCompletion:{json in })
            self.upVote.setImage(#imageLiteral(resourceName: "Image-33"), for: .normal)
            self.downVote.setImage(#imageLiteral(resourceName: "Image-15"), for: .normal)
            UserDefaults.standard.set("upvoted",forKey:String(comment.commentID))
            
            
        }
        if UserDefaults.standard.string(forKey: String(comment.commentID)) == "neutral" || UserDefaults.standard.string(forKey: String(comment.commentID)) == nil {
       
            var x = Int(karma.text!)
            x = x! +  1
            self.karma.text = String(describing: x!)
            self.upVote.setImage(#imageLiteral(resourceName: "Image-33"), for: .normal)
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
            self.downVote.setImage(#imageLiteral(resourceName: "Image-15"), for: .normal)
            UserDefaults.standard.set("neutral",forKey:String(comment.commentID))
            return
            
        }
        
        
        if UserDefaults.standard.string(forKey: String(comment.commentID)) == "upvoted" {
            var x = Int(karma.text!)
            print("this is the karma \(x)")

            x = x! -  2
            self.karma.text = String(describing: x!)
            ApiClient.vote(id: self.comment.commentID, value: x! , onCompletion:{json in })
            
            self.downVote.setImage(#imageLiteral(resourceName: "Image-32"), for: .normal)
            self.upVote.setImage(#imageLiteral(resourceName: "Image-16"), for: .normal)
            UserDefaults.standard.set("downvoted",forKey:String(comment.commentID))

            
        }
        if UserDefaults.standard.string(forKey: String(comment.commentID)) == "neutral" || UserDefaults.standard.string(forKey: String(comment.commentID)) == nil  {
            
            var x = Int(karma.text!)
            print("this is the karma \(x)")
            x = x! -  1
            self.karma.text = String(describing: x!)
            ApiClient.vote(id: self.comment.commentID, value: x! , onCompletion:{json in })
            self.downVote.setImage(#imageLiteral(resourceName: "Image-32"), for: .normal)
            UserDefaults.standard.set("downvoted",forKey:String(comment.commentID))
        }

    }
    
    
    
    
    
    
    
    
    
}
