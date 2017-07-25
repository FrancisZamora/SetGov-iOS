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
    
    @IBOutlet var profilePicture1: ProfilePicture!
    @IBOutlet var profilePicture2: ProfilePicture!
    @IBOutlet var profilePicture3: ProfilePicture!
    @IBOutlet var profilePicture4: ProfilePicture!
    @IBOutlet var profilePicture5: ProfilePicture!
    @IBOutlet var profilePicture6: ProfilePicture!
    
    
    func checkMembers() {
        ApiClient.fetchEvent(eventID:bostonIDS[indexofEvent] , onCompletion:{ json in
            
            let pictureIDArray = json["data"]["event"]["attendingUsers"].arrayValue.map({$0["profileImage"]["url"].stringValue})
            print(pictureIDArray)
            
            
            
            
            
            
        })
        

        
    }
    
    
    
    
}
