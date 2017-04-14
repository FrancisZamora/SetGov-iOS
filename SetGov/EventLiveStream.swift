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

class EventLiveStream: UITableViewCell {
    @IBOutlet var streamView: UIWebView!
    
    @IBOutlet var timeView: UIView!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var liveView: UIView!
    @IBOutlet var liveTitle: UILabel!
    
    
    func configure() {
        liveView.backgroundColor = SG_RED_COLOR
        liveView.layer.cornerRadius = 10
        liveView.layer.masksToBounds = true
        timeView.layer.cornerRadius = 10
        timeView.layer.masksToBounds = true 
    
    }
    
    func playVideo () {
        let width: CGFloat = streamView.frame.size.width
        let height = ceil((width / 16) * 9) // Assuming that the videos aspect ratio is 16:9
        
        let myVideo = "https://myvideo"
        
        let myHTML = "<iframe align=\"middle\" width=\"\(streamView.frame.size.width)\" height=\"\(streamView.frame.size.height)\" src=\"\(myVideo)?&playsinline=1\" frameborder=\"0\" allowfullscreen></iframe>"
        
        
        streamView.allowsInlineMediaPlayback = true
        streamView.loadHTMLString(myHTML, baseURL: nil)
        streamView.frame = UIScreen.main.bounds
        
        
        streamView.backgroundColor = UIColor.clear
        streamView.widthAnchor.constraint(equalToConstant: 250)
    }
    
    
}
