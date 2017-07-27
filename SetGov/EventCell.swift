//
//  EventCell.swift
//  SetGov
//
//  Created by Francis Zamora on 3/6/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore
extension UIView {
    func makeCircular() {
        self.layer.cornerRadius = min(self.frame.size.height, self.frame.size.width) / 2.0
        self.clipsToBounds = true
    }
}
class EventCell: UITableViewCell {
    var count = 0
    @IBOutlet var eventTitle: UILabel!
    @IBOutlet var eventDescription: UILabel!
    @IBOutlet var eventImage: UIImageView!
    @IBOutlet var conView: UIView!
    @IBOutlet var eventDate: UILabel!
    var selectedCity = " "
    var dataList = [Event]()
    var eventOriginalTitle = " "
    var index = 0
    var spacer = "  "

    @IBOutlet var attendee: ProfilePicture!
    
    
    func configure() {
        print("nothing here")
        
    }
    
    func editCell(Event: Event){
        eventTitle.text = Event.eventTitle        
        eventDescription.text = Event.eventDescription
        eventImage.image = Event.eventImage
        eventDate.text = Event.eventDate
        
        
        
    }
    
    
    func checkMembers(index:Int) {
        ApiClient.fetchEvents(city: selectedCity,  onCompletion: { json in
            print("this is the index")
            var  event = json["data"]["upcomingEvents"][index]
            print(event)
            var pictureIDArray = event["attendingUsers"].arrayValue.map({$0["profileImage"]["url"].stringValue})
            print(pictureIDArray)
            print("THIS IS THE ARRAY")
            self.attendee.isHidden = true
            
            for (index,_) in pictureIDArray.enumerated() {
                //var xy = 8
                //var imageView : UIImageView
                //imageView  = UIImageView(frame:CGRect(x: xy, y:271, width:35, height:35))
//                imageView.layer.cornerRadius = imageView.frame.height / 2
//                
//                imageView.clipsToBounds = true
//                imageView.layer.borderWidth = 1.5
//                imageView.layer.borderColor = UIColor(red:0.18, green:0.26, blue:0.35, alpha:1.0).cgColor
                
                let theProfileImageUrl = URL(string:pictureIDArray[index])
                do {
                    let imageData = try Data(contentsOf: theProfileImageUrl!)
                    //imageView.image = UIImage(data: imageData)
                    self.attendee.image = UIImage(data:imageData)
                    self.attendee.isHidden = false
                } catch {
                    print("Unable to load data: \(error)")
                }
                
                
                
                
                
               // self.conView.addSubview(imageView)
                //xy = xy + 51
            }
            

            
            
            
            
            
            
            
        })
        
    
        
        
        
        
    }

    
    
}
