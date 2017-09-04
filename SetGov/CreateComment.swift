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
    func retrievecommentData(comment:String)
}

class CreateComment: UITableViewCell, UITextFieldDelegate {
    @IBOutlet var commentField: UITextField!
    weak var commentCallBack: CommentCallBack!

    func replytoComment(comment:Comment){
        self.commentField.text = "@" + comment.user.fullName
    }
    
    @IBAction func createAction(_ sender: Any) {
        //print("comment being created")
        if let callback = self.commentCallBack {
            //print("callback in progress")
            
            callback.retrievecommentData(comment: self.commentField.text!)
                self.commentField.text = ""
                self.commentField.placeholder = "Enter Comment"
        }
    }
}
