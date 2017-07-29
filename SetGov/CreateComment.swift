//
//  CreateComment.swift
//  SetGov
//
//  Created by Francis Zamora on 7/28/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation
import UIKit

protocol commentCallBack: class {
    func retrievecommentData(comment:String)
}

class CreateComment: UITableViewCell, UITextFieldDelegate {
    @IBOutlet var commentField: UITextField!
    
    
    
    @IBAction func createAction(_ sender: Any) {
        print("comment being created")
        
    }
    
 
    
}
