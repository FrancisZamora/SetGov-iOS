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
extension Int {
    var array: [Int] {
        return description.characters.flatMap{Int(String($0))}
    }
}

class EventLiveStream: UITableViewCell {
    @IBOutlet var streamView: UIWebView!
    
    @IBOutlet var timeView: UIView!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var liveView: UIView!
    @IBOutlet var liveTitle: UILabel!
    var timer = Timer()
    var counter = 0
    
    func configure() {
        liveView.backgroundColor = SG_RED_COLOR
        liveView.layer.cornerRadius = 10
        liveView.layer.masksToBounds = true
        timeView.layer.cornerRadius = 10
        timeView.layer.masksToBounds = true
        if counter == 0 {
            timeLabel.text = "SWAG"
        }

        timeLabel.text = "00:00"
        print("time set to 0 ")
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(incrementTime), userInfo: nil, repeats: true)

    
    }
    
    func incrementTime() {
       
        print(counter)
        print(counter == 0)
        if counter == 0 {
            timeLabel.text = "00:00"


        }
        if counter < 60 && counter != 0  {
            timeLabel.text = " 00:" + String(counter)
        }
        
        if counter > 60 {
            if (counter % 60 == 0) {
                let minuteClock = counter/60
                print(minuteClock)
                timeLabel.text = String(minuteClock) + ":00"
            }
            if ( counter % 60 != 0 ) {
                let minuteClock = (counter / 60).array
                let newminuteClock = minuteClock[0]
                let secondClock = counter & 60
                timeLabel.text = String(newminuteClock) + ":" + String(secondClock)
                
            }
            
          
        }
        counter = counter + 1

    }
    
  //  func setTime() {
    //    timeLabel.text = String(counter)
    //}
    
    
    func playVideo () {
        
        streamView.loadRequest(URLRequest(url: URL(string: "http://franciszamora.io")!))

        
        //let url = NSURL (string: "https://franciszamora.io");
        //let request = NSURLRequest(url: url! as URL);
        //streamView.loadRequest(request as URLRequest);
    }
    
    
}
