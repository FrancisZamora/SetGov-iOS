//
//  AttendCell.swift
//  SetGov
//
//  Created by Francis Zamora on 10/16/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore
import SwiftyJSON
import Kingfisher

protocol AttendCellCallBack: class {
    func attendbuttonTapped()
}
class AttendCell: UITableViewCell {
    @IBOutlet var attendButton: UIButton!
    weak var AttendCellCallBack: AttendCellCallBack!
    var currentEvent: Event!
    var user: User!
    func checkUsers() -> Bool{
        for user in currentEvent.attendingUsers {
            if user.fullName == self.user?.fullName {
                return true
            }
        }
        return false
    }
    
    override func awakeFromNib() {
//        if(checkUsers()) {
//            self.attendButton.setTitle("Attending", for: .normal)
//        } else {
//            self.attendButton.setTitle("Attend", for: .normal)
//        }
    }
    
    @IBAction func attendAction(_ sender: Any) {
        if self.checkUsers() == true {
            ApiClient.unattendEvent(eventID: currentEvent.id, onCompletion:{ user in
                for (idx,val) in self.currentEvent.attendingUsers.enumerated() {
                    if val.fullName == self.user?.fullName {
                        self.currentEvent.attendingUsers.remove(at: idx)
                    }
                }
                //print(self.currentEvent.users)
                
                self.attendButton.setTitle("Attend", for: .normal)
                if let callback = self.AttendCellCallBack {
                    callback.attendbuttonTapped()
                    
                }
            })
            
            return
        }
        // send api request whenever button is pressed
        
        attendButton.setTitle("Attending", for: .normal)
        //print(eventTitle)
        let eventID = currentEvent.id
        //print(eventID)
        
        ApiClient.attendEvent(eventID: eventID ,onCompletion: { json in
            self.currentEvent.attendingUsers.append(self.user)
            if let callback = self.AttendCellCallBack {
                callback.attendbuttonTapped()
                
            }   else {
                //print("callback is nil")
            }
        })
      
    }
}
