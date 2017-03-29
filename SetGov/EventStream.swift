//
//  EventStream.swift
//  SetGov
//
//  Created by Francis Zamora on 3/22/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore
extension UIView {
    func makeShape() {
        self.layer.cornerRadius = min(self.frame.size.height, self.frame.size.width) / 2.0
        self.clipsToBounds = true
    }
}

class EventStream:  UITableViewCell {
    
    @IBOutlet var eventImage: UIImageView!
    @IBOutlet var secondaryEventImage: UIImageView!
    @IBOutlet var attendButton: UIButton!
    @IBOutlet var buttonBackground: GradientView!
    
    func configure() {
        buttonBackground.makeShape()
        self.secondaryEventImage.layer.cornerRadius = self.secondaryEventImage.frame.height / 2
        self.secondaryEventImage.clipsToBounds = true
        self.secondaryEventImage.layer.borderWidth = 3.0
        self.secondaryEventImage.layer.borderColor = UIColor(red:0.18, green:0.26, blue:0.35, alpha:1.0).cgColor
        print ("formatting view")
    }
    
    
}
