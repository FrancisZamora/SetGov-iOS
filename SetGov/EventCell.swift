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
class EventCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
 {
    
    @IBOutlet var usersCollection: UICollectionView!
    var count = 0
    @IBOutlet var eventTitle: UILabel!
    @IBOutlet var eventDescription: UILabel!
    @IBOutlet var eventImage: UIImageView!
    @IBOutlet var conView: UIView!
    @IBOutlet var eventDate: UILabel!
    @IBOutlet var memberCount: UILabel!
    var selectedCity = " "
    var eventOriginalTitle = " "
    var index = 0
    var spacer = "  "
    var picArray = [String]()
    var event: Event!
    var userArray = [User]()

    @IBOutlet var attendee: ProfilePicture!
    
    override func awakeFromNib() {
        usersCollection.delegate = self
        usersCollection.dataSource = self
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if event.users.count == 0 {
            return 1
        }
        return event.users.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if event.users.count == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoUsers", for: indexPath) as! NoUsers
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Attendee", for: indexPath) as! Attendee
        
        print(event.users)
        print(event.users[indexPath.row].profilePictureURL)
        
        cell.configure(imageUrl: event.users[indexPath.row].profilePictureURL)
        
        return cell
    }
    
    
    func configure(event: Event) {
        selectionStyle = .none
        eventTitle.text = event.title
        eventDescription.text = event.description
        eventImage.image = event.image
        eventDate.text = event.eventDate
        self.userArray = event.users
        memberCount.text = "\(event.users.count)"
      
        self.event = event
        print(event.users)
        self.usersCollection.reloadData()
        
    }
  
}
