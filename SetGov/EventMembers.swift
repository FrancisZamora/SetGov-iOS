//
//  EventMembers.swift
//  SetGov
//
//  Created by Francis Zamora on 3/22/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation
import UIKit

class EventMembers: UITableViewCell {
    
    var bostonIDS = [Int]()
    var fortlauderdaleIDS = [Int]()
    var indexofEvent = 0
    
        @IBOutlet var conView: UIView!
  
    
    func checkMembers() {
            ApiClient.fetchEvent(eventID:bostonIDS[indexofEvent] , onCompletion:{ json in
            
            let pictureIDArray = json["data"]["event"]["attendingUsers"].arrayValue.map({$0["profileImage"]["url"].stringValue})
            print(pictureIDArray)
            for (index,_) in pictureIDArray.enumerated() {
                var xy = 8
                var imageView : UIImageView
                imageView  = UIImageView(frame:CGRect(x: xy, y:42, width:35, height:35))
                imageView.layer.cornerRadius = imageView.frame.height / 2

                imageView.clipsToBounds = true
                imageView.layer.borderWidth = 1.5
                imageView.layer.borderColor = UIColor(red:0.18, green:0.26, blue:0.35, alpha:1.0).cgColor
                let theProfileImageUrl = URL(string:pictureIDArray[index])
                do {
                    let imageData = try Data(contentsOf: theProfileImageUrl!)
                    imageView.image = UIImage(data: imageData)
                } catch {
                    print("Unable to load data: \(error)")
                }
               

                self.conView.addSubview(imageView)
                xy = xy + 48
            }
            
            
            
            
            
        })
        

        
    }
    
    
    
    
}
