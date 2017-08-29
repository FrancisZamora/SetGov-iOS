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
    
    var eventTitle = " "
    var selectedCity = " "
    //var timer = Timer()
    var counter = 0
    
    func configure() {
        liveView.backgroundColor = SG_RED_COLOR
        liveView.layer.cornerRadius = 10
        liveView.layer.masksToBounds = true
        
//        timeView.layer.cornerRadius = 10
//        timeView.layer.masksToBounds = true
//
//        timeLabel.text = " 00:00"
//        print("time set to 0 ")
//        print(eventTitle)
//        
//        if UserDefaults.standard.string(forKey: eventTitle) != "increment" {
//            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(incrementTime), userInfo: nil, repeats: true )
//            UserDefaults.standard.set("increment", forKey: eventTitle)
//        }
    }
    
    func switchTitleOff() {
        liveView.isHidden = true
    }
    
    func switchTitleOn() {
        liveView.isHidden = false
        print("title on")
    }
    
//    func incrementTime() {
//       
//        print(counter)
//        print(counter == 0)
//        if counter == 0 {
//            timeLabel.text = " 00:00"
//
//
//        }
//       
//        if counter < 60 && counter != 0  {
//            timeLabel.text = " 00:" + String(counter)
//        }
//        var minuteClock = (counter / 60).array
//        print(minuteClock[0])
//        
//        let newminuteClock = minuteClock[0]
//        let secondClock = counter - (newminuteClock * 60)
//        var secondHand = " "
//        
//        if counter > 60 {
//            if (counter % 60 == 0) {
//                timeLabel.text = String(describing: minuteClock) + ":00"
//            }
//            if ( counter % 60 != 0 ) {
//                timeLabel.text = " " + String(newminuteClock) + ":" + String(secondHand)
//                
//            }
//            if secondClock < 10 {
//                secondHand = "0" + String(secondClock)
//            }
//            if secondClock >= 10 {
//                secondHand = String(secondClock)
//            }
//            
//
//            
//            if counter < 600 {
//             
//                timeLabel.text = " 0" + String(newminuteClock) + ":" + String(secondHand)
//            }
//            
//          
//        }
//        counter = counter + 1
//
//    }
 
    func playVideo () {
        if selectedCity == "Boston" {
           let youtubeURL = "https://www.youtube.com/embed/ZqMhZgiBt_4"
           streamView.loadHTMLString("<iframe width=\"\(streamView.frame.width)\" height=\"\(streamView.frame.height)\" src=\"\(youtubeURL)?&playsinline=1\" frameborder=\"0\" allowfullscreen></iframe>", baseURL:nil)
            streamView.allowsInlineMediaPlayback = true
            streamView.mediaPlaybackRequiresUserAction = false
        }
        
        if selectedCity == "Fort Lauderdale" {
            let youtubeURL = "https://fortlauderdale.granicus.com/MediaPlayer.php?view_id=2&clip_id=732&embed=1"
            streamView.loadHTMLString("<iframe width= 500 height= 400 frameborder= 0 src=\"\(youtubeURL)?&playsinline=1\" frameborder=\"0\" allowfullscreen></iframe>", baseURL:nil)
            streamView.allowsInlineMediaPlayback = true
            streamView.mediaPlaybackRequiresUserAction = false
        }
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        print("SHOULD START LOAD")
        return true
    }
}
