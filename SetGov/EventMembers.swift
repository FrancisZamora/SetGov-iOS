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
    
    var bostonIDS = [Int]()
    var fortlauderdaleIDS = [Int]()
    var indexofEvent = 0
    var picArray = [String]()
    
    @IBOutlet var conView: UIView!
    @IBOutlet var userCollection: UICollectionView!

    override func awakeFromNib() {
        userCollection.delegate = self
        userCollection.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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


    

    
    
    
    
}
