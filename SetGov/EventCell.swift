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
class EventCell: UITableViewCell {
    var count = 0
    @IBOutlet var eventTitle: UILabel!
    @IBOutlet var eventDescription: UILabel!
    @IBOutlet var eventImage: UIImageView!
    @IBOutlet var hashTagView: UIView!
    @IBOutlet var hashtagOne: UILabel!
    
    @IBOutlet var eventDate: UILabel!
    @IBOutlet var hashtagView2: GradientView!
    @IBOutlet var hashtagTwo: GradientView!
    
    @IBOutlet var profileImage1: ProfilePicture!
   
    @IBOutlet var profileImage2: ProfilePicture!
   
    @IBOutlet var profileImage3: ProfilePicture!
   
    @IBOutlet var profileImage4: ProfilePicture!
    
    @IBOutlet var profileImage5: ProfilePicture!
    
    @IBOutlet var profileImage6: ProfilePicture!
    
    func willShape() {
        hashtagView2.makeCircular()
        hashTagView.makeCircular()
        
    }
    
    
    
}
