//
//  CreateComment.swift
//  SetGov
//
//  Created by Francis Zamora on 7/28/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation
import UIKit

protocol CommentCallBack: class {
    func retrievecommentData(comment: String, replyCommentId: Int?)
}

class CreateComment: UITableViewCell, UITextFieldDelegate {
    @IBOutlet var commentField: UITextField!
    weak var commentCallBack: CommentCallBack!
    
    var replyCommentId: Int?

    func replytoComment(comment:Comment){
        self.commentField.text = "@" + comment.user.fullName
        self.replyCommentId = comment.commentID
    }
    
    @IBAction func createAction(_ sender: Any) {
        //print("comment being created")
        if let callback = self.commentCallBack {
            //print("callback in progress")
            
            callback.retrievecommentData(comment: self.commentField.text!, replyCommentId: replyCommentId)
            self.commentField.text = ""
            self.commentField.placeholder = "Enter Comment"
        }
    }
}
