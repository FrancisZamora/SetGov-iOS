//
//  EventStream.swift
//  SetGov
//
//  Created by Francis Zamora on 3/22/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore
import SwiftyJSON
import Kingfisher
protocol EventStreamCallback: class {
    func refreshTap(tapped:Bool)
    func attendbuttonTapped()
}

extension UIView {
    func makeShape() {
        //print("called")
        self.layer.cornerRadius = min(self.frame.size.height, self.frame.size.width) / 2.0
        self.clipsToBounds = true
    }
}

class EventStream:  UITableViewCell {
    @IBOutlet var eventImage: UIImageView!
    @IBOutlet var secondaryEventImage: UIImageView!
    @IBOutlet var attendButton: UIButton!
    @IBOutlet var buttonBackground: GradientView!
    
    @IBOutlet var background: UIView!
    @IBOutlet var eventDescription: UILabel!
    var pressedButton: Bool?
    var onePress: Bool = false
    var dataList = [Event]()
    var initiateStream: Bool = false
    var firstpress: Bool = true
    var EventDetailViewController:EventDetailViewController?
    @IBInspectable var startColor: UIColor = SG_RED_COLOR
    @IBInspectable var endColor: UIColor = UIColor.red
    var countDown = 0
    var presentStream: Bool = false
    var timer = Timer()
    var eventInfo = [Int: [String]]()
    var currentTime = " "
    var timeArray = [String]()
    var eventTime = [String]()
    var indexofEvent = 0
    var selectedCity = " "
    var eventTimeNoFormat = [String]()
    var finalArray =  [String]()
    var currentHour = String()
    var eventHours = [[String]()]
    var bostonDataList = [Event]()
    var fortlauderdaleDataList = [Event]()
    var eventTitle = " "
    var currentEvent: Event!
    var user: User!

    weak var eventStreamCallback: EventStreamCallback!

    var eventTVController: EventDetailViewController?
    
    func configureImage() {
        //print(self.user.fullName)
        //print(self.user.profilePictureURL)
        
        let theProfileImageUrl = URL(string:self.user.profilePictureURL)
        secondaryEventImage.kf.setImage(with: theProfileImageUrl)
    }
    
    func configureColor () {
        buttonBackground.startColor = SG_SECONDARY_REDCOLOR
        buttonBackground.endColor = UIColor.red
        //print("configuring color")
    }
    
    func activateStream () {
        self.initiateStream = true
    }
    
    func checkStream()-> Bool {
        if (presentStream == true) {
            return true
        }
        return false
    }
    
    func increment() {
        if countDown >= 2 {
            countDown+=1
            //print("we hit increment")
        }
    }
    
    func configureTime() -> String{
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month,from:date)
        let year = calendar.component(.year, from: date)
        let dateString = String(month) + "/" + String(day) + "/" + String(year) + " " + String(hour)
        
        timeArray.append(String(month) + "/" + String(day) + "/" + String("17"))
        
        //timeArray.append(String(hour) + ":00")
        
        //print (timeArray)
        //print("time array")
        
        return dateString
    }
    
    func configureHour() {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let hourString = String(hour)
        currentHour = hourString
    }
    
    func compareTime() -> Bool {
        if selectedCity == "Fort Lauderdale" {
            return false
        }
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        let newDate = dateFormatter.string(from: date)
        //print(newDate)
        
        let x = newDate == bostonDataList[indexofEvent].date
        //print(x)
        self.configureHour()
        //print(eventHours)
        
        let y = currentHour >=  bostonDataList[indexofEvent].time
        //print(currentHour)
        //print(y)
        
        if x && y  {
            //print("times are compatible")
            return true
        } else {
            //print("times not compatible")
            return false
        }
    }
    
    func streamContent() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(increment), userInfo: nil, repeats: true)
        //print("streamContent initiliazing")

        //if (self.initiateStream == true) {
        //  self.EventDetailViewController?.tableView.reloadData()
        //  print("reloading data")
        //  self.presentStream = true
        //  print("present Stream")
        //}
    }
    
    func nowLive() {
        if self.onePress == false {
            self.configureColor()
            self.pressedButton = true
            buttonBackground.startColor = SG_SECONDARY_REDCOLOR
            buttonBackground.endColor = UIColor.red
            self.EventDetailViewController?.animateView = true
            self.attendButton.setTitle("Now Live", for: .normal)
            self.buttonBackground.startColor = SG_SECONDARY_REDCOLOR
            self.buttonBackground.endColor = UIColor.red
            self.buttonBackground.backgroundColor = SG_RED_COLOR
            let transition: CATransition = CATransition()
            transition.duration = 0.5
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionReveal
            transition.subtype = kCATransitionFromRight
            self.buttonBackground.layer.add(transition,forKey:nil)
            self.attendButton.layer.add(transition, forKey: nil)
            self.attendButton.layer.cornerRadius = self.attendButton.frame.height / 2
            self.attendButton.clipsToBounds = true
            self.attendButton.layer.borderWidth = 1.5
            self.attendButton.layer.borderColor = UIColor(red:0.18, green:0.26, blue:0.35, alpha:0.0).cgColor
            buttonBackground.startColor = SG_SECONDARY_REDCOLOR
            buttonBackground.endColor = UIColor.red
            //print(buttonBackground.startColor)
            //print( "adding gradient")
            let transition2: CATransition = CATransition()
            transition2.duration = 0.5
            transition2.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition2.type = kCATransitionReveal
            transition2.subtype = kCATransitionFromRight
            self.secondaryEventImage.layer.add(transition2, forKey: nil)
            self.secondaryEventImage.layer.cornerRadius = self.secondaryEventImage.frame.height / 2
            self.secondaryEventImage.clipsToBounds = true
            self.secondaryEventImage.layer.borderWidth = 3.0
            self.secondaryEventImage.layer.borderColor = SG_RED_COLOR.cgColor
            
            self.onePress = true
        }
    }
    
    func checkUsers() -> Bool{
        for (_,val) in currentEvent.users.enumerated() {
            if val.fullName == self.user?.fullName {
                return true
            }
        }
        return false
    }
    
    func checkStatus() -> Bool {
        var x = false

        ApiClient.fetchEvent(eventID:currentEvent.id , onCompletion:{ json in
            if self.checkUsers() == true {
                self.attendButton.setTitle("Attending", for: .normal)
                self.secondaryEventImage.isHidden = false
                x = true
            } else {
                self.attendButton.setTitle("Attend", for: .normal)
                self.secondaryEventImage.isHidden = true
            }
        })
            
        if compareTime() == true {
            self.nowLive()
            firstpress = false
        }
        
        return x
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        if self.checkUsers() == true {
            ApiClient.unattendEvent(eventID: currentEvent.id, onCompletion:{ user in
                for (idx,val) in self.currentEvent.users.enumerated() {
                    if val.fullName == self.user?.fullName {
                        self.currentEvent.users.remove(at: idx)
                    }
                }
                //print(self.currentEvent.users)
                
                self.attendButton.setTitle("Attend", for: .normal)
                if let callback = self.eventStreamCallback {
                    //print("callback in progress")
                    
                    callback.attendbuttonTapped()
                }
            })
            
            return 
        }
        // send api request whenever button is pressed
  
        self.attendButton.setTitle("Attending", for: .normal)
        //print(eventTitle)
        self.eventTitle  =  "  " + self.eventTitle
        let eventID = currentEvent.id
        //print(eventID)
        
        ApiClient.attendEvent(eventID: eventID ,onCompletion: { json in
            self.currentEvent.users.append(self.user)
            if let callback = self.eventStreamCallback {
                //print("callback in progress")
                        
                callback.attendbuttonTapped()
                        
            } else {
                //print("callback is nil")
            }
        })
                
        if compareTime() == true {
            self.nowLive()
        }
        
        firstpress = false

        if compareTime() == true {
            //print(compareTime())
            let when1 = DispatchTime.now() + 1  // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when1) {
                self.nowLive()
            }
        }

        let when2 = DispatchTime.now() + 2  // change 2 to desired number of seconds
        
        DispatchQueue.main.asyncAfter(deadline: when2) {
            if let callback = self.eventStreamCallback {
                callback.refreshTap(tapped: true)
            }
        }
    }
    
    func buttonwasPressed() -> Bool {
        if (pressedButton == true) {
            return true
        }
        else {
            return false
        }
    }
    
    func buttonPressed() {
        self.EventDetailViewController?.animateView = true
    }

    func configure() {
        if self.onePress == false {
            buttonBackground.makeShape()
            self.secondaryEventImage.layer.cornerRadius = self.secondaryEventImage.frame.height / 2
            self.secondaryEventImage.clipsToBounds = true
            self.secondaryEventImage.layer.borderWidth = 3.0
            self.secondaryEventImage.layer.borderColor = UIColor(red:0.18, green:0.26, blue:0.35, alpha:1.0).cgColor
            //print ("formatting view")
        }
    }
}
