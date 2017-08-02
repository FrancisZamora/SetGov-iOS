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
        self.userCollection.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("this is the pic array for event detail")
        print(picArray)
        
        return picArray.count
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Attendee", for: indexPath) as! Attendee
        print("THIS IS THE PIC ARRAY FOR EVENT DETAIL")
        print(self.picArray)
        cell.configure()
        cell.generateImage(rawData: picArray[indexPath.row])
        
        return cell
    }
    
    


    

    
    
    
    
}
