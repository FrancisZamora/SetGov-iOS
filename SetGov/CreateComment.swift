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

class CreateComment: UITableViewCell, UITextViewDelegate {
    //@IBOutlet var commentField: UITextField!
    weak var commentCallBack: CommentCallBack!
    @IBOutlet weak var mTextView: UITextView!
    
    var replyCommentId: Int?

    
    override func awakeFromNib() {
        mTextView.delegate = self
        mTextView.text = "Add Comment..."
        mTextView.textColor = UIColor.lightGray
        
    }
    
    func replytoComment(comment:Comment){
        self.mTextView.text = "@" + comment.user.fullName
        self.replyCommentId = comment.commentID
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            createComment()
            mTextView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Add Comment"
            textView.textColor = UIColor.lightGray
        }
    }
    
    func createComment() {
                //print("comment being created")
                if let callback = self.commentCallBack {
                    //print("callback in progress")
        
                    callback.retrievecommentData(comment: self.mTextView.text!, replyCommentId: replyCommentId)
                    self.mTextView.text = "Add Comment"
                    self.mTextView.textColor = .lightGray
                }
    }
    
//    @IBAction func createAction(_ sender: Any) {

//        }
//    }
}
