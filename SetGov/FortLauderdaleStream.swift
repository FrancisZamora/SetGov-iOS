//
//  FortLauderdaleStream.swift
//  SetGov
//
//  Created by Francis Zamora on 8/16/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation
import UIKit

class FortLauderdaleStream: UITableViewCell {
    var indexofEvent = 0
    var fortlauderdaleDataList = [Event]()

    @IBOutlet var streamer: UIWebView!
    
    func playVideo(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //print(appDelegate.fortlauderdaleStreams)
        
        var urlArray = appDelegate.fortlauderdaleStreams
        
        urlArray = urlArray.filter { Int($0)! <= 743 }
            
        //print(urlArray)
        
        if urlArray.count == 0 {
            return
        }
        
        if urlArray.count < indexofEvent + 1  {
            return
        }

        let x = "https://fortlauderdale.granicus.com/MediaPlayer.php?view_id=2&clip_id=" + String(describing: urlArray[indexofEvent])
        
        //print(x)
        
        let url = URL(string: x )
        //print(url)
        
        //print("URL HERE \(url)")
        let request = URLRequest(url: url!)
        streamer.loadRequest(request)
    }
}
