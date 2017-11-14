//
//  EventInfo.swift
//  SetGov
//
//  Created by Francis Zamora on 3/22/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

protocol EventInfoCallback: class {
    func loadDirections()
}

class EventInfo: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet var rsvp: UILabel!
    @IBOutlet var userCount: UILabel!
    @IBOutlet var backGround: UIView!
    @IBOutlet var eventHour: UILabel!
    @IBOutlet var eventAddress: UILabel!
    @IBOutlet var eventTime: UILabel!
    @IBOutlet weak var mDirectionsButton: UIView!
    @IBOutlet var collectionView: UICollectionView!
    var event: Event!
    

    weak var eventInfoCallback: EventInfoCallback?
    override func awakeFromNib() {
       
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView.reloadData()
    }
    
    func configure(event: Event) {
        eventTime.text = event.eventDate + ", 2017"
        userCount.text = String(event.attendingUsers.count)
        backGround.layer.cornerRadius = 10
        selectionStyle = .none
        self.event = event
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(event.attendingUsers.count)
        if event.attendingUsers.count != 0 {
            rsvp.isHidden = true
        }
        if event.attendingUsers.count == 0 {
            rsvp.isHidden = false
        }
        return event.attendingUsers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Attendee", for: indexPath) as! Attendee
        //print("THIS IS THE PIC ARRAY FOR EVENT DETAIL")
        cell.configure(imageUrl: event.attendingUsers[indexPath.row].profilePictureURL)
        
        return cell
    }

   
    
    func loadDirections() {
        if let callback = eventInfoCallback {
            callback.loadDirections()
        }
    }
}
