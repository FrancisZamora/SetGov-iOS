//
//  EventMembers.swift
//  SetGov
//
//  Created by Francis Zamora on 3/22/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation
import UIKit

class EventMembers: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var indexofEvent = 0
    //var picArray = [String]()
    var event: Event!
    @IBOutlet var conView: UIView!
    @IBOutlet var userCollection: UICollectionView!

    override func awakeFromNib() {
        userCollection.delegate = self
        userCollection.dataSource = self
        self.userCollection.reloadData()
        
    }
    
    func configure(event: Event) {
        selectionStyle = .none
        self.event = event
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return event.users.count
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Attendee", for: indexPath) as! Attendee
        print("THIS IS THE PIC ARRAY FOR EVENT DETAIL")
        cell.configure(imageUrl: event.users[indexPath.row].profilePictureURL)
        
        return cell
    }
    
    


    

    
    
    
    
}
