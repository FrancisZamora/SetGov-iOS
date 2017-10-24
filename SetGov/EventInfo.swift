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
        selectionStyle = .none
        self.event = event
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(event.users.count)
        
        return event.users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Attendee", for: indexPath) as! Attendee
        //print("THIS IS THE PIC ARRAY FOR EVENT DETAIL")
        cell.configure(imageUrl: event.users[indexPath.row].profilePictureURL)
        
        return cell
    }

   
    
    func loadDirections() {
        if let callback = eventInfoCallback {
            callback.loadDirections()
        }
    }
}
