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
    @IBOutlet var commentField: UITextView!
    func disableEditing() {
        commentField.isUserInteractionEnabled = false
    }

    
    
}
