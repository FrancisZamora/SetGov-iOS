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
        
        streamView.loadRequest(URLRequest(url: URL(string: "http://franciszamora.io")!))

        
        //let url = NSURL (string: "https://franciszamora.io");
        //let request = NSURLRequest(url: url! as URL);
        //streamView.loadRequest(request as URLRequest);
    }
    
    
}
