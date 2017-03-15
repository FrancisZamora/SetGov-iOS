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
    func applyGradient(colours: [UIColor]) -> Void {
        self.applyGradient(colours: colours, locations: nil)
    }
    
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
    }
}
class EventCell: UITableViewCell {
    var count = 0
    @IBOutlet var eventTitle: UILabel!
    @IBOutlet var eventDescription: UILabel!
    @IBOutlet var eventDate: UILabel!
    @IBOutlet var eventImage: UIImageView!
    @IBOutlet var hashtagOne: UILabel!
    
    @IBOutlet var hashtagTwo: UILabel!
    
    @IBOutlet var profileImage1: UIImageView!
   
    @IBOutlet var profileImage2: UIImageView!
   
    @IBOutlet var profileImage3: UIImageView!
   
    @IBOutlet var profileImage4: UIImageView!
    
    @IBOutlet var profileImage5: UIImageView!
    
    @IBOutlet var profileImage6: UIImageView!
    
}
