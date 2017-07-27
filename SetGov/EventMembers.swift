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
        //self.checkMembers()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picArray.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Attendee", for: indexPath) as! Attendee
        cell.generateImage(rawData: picArray[indexPath.row])
        
        return cell
    }


    
    
  //  func checkMembers() {
    //        print(bostonIDS)
      //      ApiClient.fetchEvent(eventID:bostonIDS[indexofEvent] , onCompletion:{ json in
            
        //    let pictureIDArray = json["data"]["event"]["attendingUsers"].arrayValue.map({$0["profileImage"]["url"].stringValue})
          //  print(pictureIDArray)
            //self.picArray = pictureIDArray
                
            
            
       // })
        

        
    //}
    
    
    
    
}
