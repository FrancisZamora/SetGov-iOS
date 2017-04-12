//
//  EventLiveStream.swift
//  SetGov
//
//  Created by Francis Zamora on 4/11/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

class LiveStream: UITableViewCell {
    @IBOutlet var streamView: UIWebView!
    
    @IBOutlet var timeView: UIView!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var liveView: UIView!
    @IBOutlet var liveTitle: UILabel!
    
    
    func configure() {
        liveView.backgroundColor = SG_RED_COLOR
    
    }
    
    
}
