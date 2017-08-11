//
//  EventInfo.swift
//  SetGov
//
//  Created by Francis Zamora on 3/22/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

protocol EventInfoCallback: class {
    func loadDirections()
}

class EventInfo: UITableViewCell {
    
    @IBOutlet var eventHour: UILabel!
    @IBOutlet var eventAddress: UILabel!
    
    @IBOutlet var eventTime: UILabel!
    
    
    @IBOutlet weak var mDirectionsButton: UIView!
    
    weak var eventInfoCallback: EventInfoCallback?
    
    override func awakeFromNib() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(loadDirections))
        mDirectionsButton.addGestureRecognizer(tap)
    }
    
    func loadDirections() {
        if let callback = eventInfoCallback {
            callback.loadDirections()
        }
    }
    
    
}

