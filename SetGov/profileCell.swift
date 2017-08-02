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
        profileName.text = self.user.fullName
        
        let theProfileImageUrl = URL(string:self.user.profilePictureURL)
            do {
                profilePic.kf.setImage(with: theProfileImageUrl)
            } catch {
                print("Unable to load data: \(error)")
            }
        }
    
    
    
    
  

}
