//
//  AgendaDetailComments.swift
//  SetGov
//
//  Created by Francis Zamora on 4/6/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation
import QuartzCore
import UIKit

class AgendaDetailComments: UITableViewCell {
    
    @IBOutlet var closingComments: UILabel!
    
    @IBOutlet var commentField: UITextView!
    
    func disableEditing() {
        commentField.isUserInteractionEnabled = false 
    }
    
    
}
