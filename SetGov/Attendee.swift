//
//  Attendee.swift
//  SetGov
//
//  Created by Francis Zamora on 7/27/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class Attendee: UICollectionViewCell {
    @IBOutlet var userPicture: UIImageView!
    
    func configure() {
        userPicture.layer.cornerRadius = userPicture.frame.height / 2
        userPicture.clipsToBounds = true
        userPicture.layer.borderWidth = 1.5
        userPicture.layer.borderColor = UIColor(red:0.18, green:0.26, blue:0.35, alpha:1.0).cgColor
        
    }
    
    func generateImage(rawData:String) {
        let theProfileImageUrl = URL(string:rawData)
        do {
            print(rawData)
            
            userPicture.kf.setImage(with: theProfileImageUrl)
            print("image created")
            
        } catch {
            print("Unable to load data: \(error)")
            print("image failed")
        }

    }
    
    
}
