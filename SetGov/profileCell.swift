//
//  profileCell.swift
//  SetGov
//
//  Created by Francis Zamora on 7/7/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation
import UIKit

class profileCell: UITableViewCell {
    @IBOutlet var backgroundPic: UIImageView!
    var user: User!
    @IBOutlet var profilePic: ProfilePicture!
    @IBOutlet var profileName: UILabel!
    
    func configure() {
        if UserDefaults.standard.string(forKey: "homeCity")! == "Boston" {
            
            backgroundPic.image = #imageLiteral(resourceName: "Image-30")
        }
        if UserDefaults.standard.string(forKey: "homeCity")! == "Fort Lauderdale" {
            backgroundPic.image = #imageLiteral(resourceName: "Image-25")
        }
       
        profileName.text = self.user.fullName
        
        let theProfileImageUrl = URL(string:self.user.profilePictureURL)
            do {
                profilePic.layer.borderWidth = 0 
                profilePic.kf.setImage(with: theProfileImageUrl)
            } catch {
                print("Unable to load data: \(error)")
            }
        }
    
    
    
    
  

}
