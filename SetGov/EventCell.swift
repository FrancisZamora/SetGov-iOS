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
class EventCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var usersCollection: UICollectionView!
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
    var picArray = [String]()

    @IBOutlet var attendee: ProfilePicture!
    
    override func awakeFromNib() {
        usersCollection.delegate = self
        usersCollection.dataSource = self
        self.usersCollection.reloadData()

    }
    


    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("this is the pic array")
        print(picArray)
        return picArray.count
 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Attendee", for: indexPath) as! Attendee
        print("THIS IS THE PIC ARRAY")
        print(self.picArray)
        cell.configure()
        cell.generateImage(rawData: picArray[indexPath.row])
        
        return cell
    }
    
    
    func configure() {
        print("nothing here")
        
    }
    
    func editCell(Event: Event){
        eventTitle.text = Event.eventTitle        
        eventDescription.text = Event.eventDescription
        eventImage.image = Event.eventImage
        eventDate.text = Event.eventDate
        
        
        
    }
  
}
