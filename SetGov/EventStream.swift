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
    
    @IBOutlet var eventTitlelabel: UILabel!
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
    }
    
    func configureColor () {
        
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
            self.EventDetailViewController?.animateView = true
            self.onePress = true
        }
    }
    
    func checkUsers() -> Bool{
        for (_,val) in currentEvent.attendingUsers.enumerated() {
            if val.fullName == self.user?.fullName {
                return true
            }
        }
        return false
    }
    
    func checkStatus() -> Bool {
        var x = false

        ApiClient.fetchEvent(eventID:currentEvent.id)
            .then { event -> Void in
                if self.checkUsers() == true {
                    x = true
                }
            }
            
        if compareTime() == true {
            self.nowLive()
            firstpress = false
        }
        
        return x
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        if self.checkUsers() == true {
            ApiClient.unattendEvent(eventID: currentEvent.id, onCompletion:{ user in
                for (idx,val) in self.currentEvent.attendingUsers.enumerated() {
                    if val.fullName == self.user?.fullName {
                        self.currentEvent.attendingUsers.remove(at: idx)
                    }
                }
                //print(self.currentEvent.users)
                
                if let callback = self.eventStreamCallback {
                    //print("callback in progress")
                    
                    callback.attendbuttonTapped()
                }
            })
            
            return 
        }
        // send api request whenever button is pressed
  
        //print(eventTitle)
        self.eventTitle  =  "  " + self.eventTitle
        let eventID = currentEvent.id
        //print(eventID)
        
        ApiClient.attendEvent(eventID: eventID ,onCompletion: { json in
            self.currentEvent.attendingUsers.append(self.user)
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
            
            //print ("formatting view")
        }
    }
}
