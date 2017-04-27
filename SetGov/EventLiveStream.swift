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
       

        timeLabel.text = " 00:00"
        print("time set to 0 ")
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(incrementTime), userInfo: nil, repeats: true)

    
    }
    
    func incrementTime() {
       
        print(counter)
        print(counter == 0)
        if counter == 0 {
            timeLabel.text = " 00:00"


        }
       
        if counter < 60 && counter != 0  {
            timeLabel.text = " 00:" + String(counter)
        }
        var minuteClock = (counter / 60).array
        print(minuteClock[0])
        
        let newminuteClock = minuteClock[0]
        let secondClock = counter - (newminuteClock * 60)
        var secondHand = " "
        
        if counter > 60 {
            if (counter % 60 == 0) {
                timeLabel.text = String(describing: minuteClock) + ":00"
            }
            if ( counter % 60 != 0 ) {
                timeLabel.text = " " + String(newminuteClock) + ":" + String(secondHand)
                
            }
            if secondClock < 10 {
                secondHand = "0" + String(secondClock)
            }
            if secondClock >= 10 {
                secondHand = String(secondClock)
            }
            

            
            if counter < 600 {
             
                timeLabel.text = " 0" + String(newminuteClock) + ":" + String(secondHand)
            }
            
          
        }
        counter = counter + 1

    }
 
    
    
    func playVideo () {
        
        
       //streamView.loadRequest(URLRequest(url: URL(string: "https://www.youtube.com/watch?v=Mgy4Q7bTheg&autoplay=1")!))
        // embed html 5 video 
        //streamView.scrollView.bounces = false
       
        let youtubeURL = "https://www.youtube.com/embed/Mgy4Q7bTheg"
        streamView.loadHTMLString("<iframe width=\"\(streamView.frame.width)\" height=\"\(streamView.frame.height)\" src=\"\(youtubeURL)?&playsinline=1&autoplay=1\" frameborder=\"0\" allowfullscreen></iframe>", baseURL:nil)
        streamView.allowsInlineMediaPlayback = true
        streamView.mediaPlaybackRequiresUserAction = false


      
        //streamView.mediaPlaybackRequiresUserAction = false
              
        //let url = NSURL (string: "https://franciszamora.io");
        //let request = NSURLRequest(url: url! as URL);
        //streamView.loadRequest(request as URLRequest);
    }
    
    
}
