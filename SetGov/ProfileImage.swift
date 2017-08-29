//
//  ProfileImage.swift
//  SetGov
//
//  Created by Francis Zamora on 3/15/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

class ProfilePicture: UIImageView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //print("req inti RoundedFloatingImageButton")
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
        self.layer.borderWidth = 1.5
        self.layer.borderColor = UIColor(red:0.18, green:0.26, blue:0.35, alpha:1.0).cgColor
    }
}
