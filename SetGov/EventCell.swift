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
class EventCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var usersCollection: UICollectionView!
    @IBOutlet var eventTitle: UILabel!
    @IBOutlet var eventDescription: UILabel!
    @IBOutlet var eventImage: UIImageView!
    @IBOutlet var conView: UIView!
    @IBOutlet var eventDate: UILabel!
    @IBOutlet var memberCount: UILabel!
    var count = 0
    var selectedCity = " "
    var eventOriginalTitle = " "
    var index = 0
    var spacer = "  "
    var picArray = [String]()
    var event: Event!

    @IBOutlet var colorBackground: UIView!
    @IBOutlet var attendee: ProfilePicture!
    
    override func awakeFromNib() {
        usersCollection.delegate = self
        usersCollection.dataSource = self
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return event.users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Attendee", for: indexPath) as! Attendee
        
        //print(event.users)
        //print(event.users[indexPath.row].profilePictureURL)
        
        cell.configure(imageUrl: event.users[indexPath.row].profilePictureURL)
        
        return cell
    }
    
    func configure(event: Event) {
        colorBackground.layer.cornerRadius = 10 
        selectionStyle = .none
        eventTitle.text = event.title
        eventDescription.text = event.description
        eventImage.image = event.image
        eventDate.text = event.eventDate
        memberCount.text = "\(event.users.count)"
        self.event = event
        
        if(event.users.count > 0) {
            usersCollection.isHidden = false 
            self.usersCollection.reloadData()
        } else {
            usersCollection.isHidden = true
        }
    }
}
