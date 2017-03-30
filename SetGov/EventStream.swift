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
        print("called")
        self.layer.cornerRadius = min(self.frame.size.height, self.frame.size.width) / 2.0
        self.clipsToBounds = true
    }
}

class EventStream:  UITableViewCell {
    
    @IBOutlet var eventImage: UIImageView!
    @IBOutlet var secondaryEventImage: UIImageView!
    @IBOutlet var attendButton: UIButton!
    @IBOutlet var buttonBackground: GradientView!
    var pressedButton: Bool?
    var onePress: Bool = false 
    var EventDetailViewController:EventDetailViewController?
    @IBInspectable var startColor: UIColor = SG_RED_COLOR
    @IBInspectable var endColor: UIColor = UIColor.red
    
    
    

    
    @IBAction func buttonPressed(_ sender: Any) {
        if self.onePress == false {
        self.pressedButton = true
        buttonBackground.startColor = SG_SECONDARY_REDCOLOR
        buttonBackground.endColor = UIColor.red
        self.EventDetailViewController?.animateView = true
        self.attendButton.setTitle("Now Live", for: .normal)
        let transition: CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionReveal
        transition.subtype = kCATransitionFromRight
        self.attendButton.layer.add(transition, forKey: nil)
        self.attendButton.layer.cornerRadius = self.attendButton.frame.height / 2
        self.attendButton.clipsToBounds = true
        self.attendButton.layer.borderWidth = 1.5
        self.attendButton.layer.borderColor = UIColor(red:0.18, green:0.26, blue:0.35, alpha:0.0).cgColor
        
        if (self.pressedButton == true) {
     
            buttonBackground.startColor = SG_SECONDARY_REDCOLOR
            buttonBackground.endColor = UIColor.red
            print( "adding gradient")
        }

        print("BUTTON WAS PRESSED")
        let transition2: CATransition = CATransition()
        transition2.duration = 0.5
        transition2.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition2.type = kCATransitionReveal
        transition2.subtype = kCATransitionFromRight
        self.secondaryEventImage.layer.add(transition2, forKey: nil)
        self.secondaryEventImage.layer.cornerRadius = self.secondaryEventImage.frame.height / 2
        self.secondaryEventImage.clipsToBounds = true
        self.secondaryEventImage.layer.borderWidth = 3.0
        self.secondaryEventImage.layer.borderColor = SG_RED_COLOR.cgColor
        self.onePress = true

        }

       
    }
    
    func buttonwasPressed() -> Bool {
        if (pressedButton == true) {
            return true
        }
        else {
            return false
        }
    }
    func buttonPressed() {
        self.EventDetailViewController?.animateView = true
    }


    func configure() {
        if self.onePress == false {
            buttonBackground.makeShape()
            self.secondaryEventImage.layer.cornerRadius = self.secondaryEventImage.frame.height / 2
            self.secondaryEventImage.clipsToBounds = true
            self.secondaryEventImage.layer.borderWidth = 3.0
            self.secondaryEventImage.layer.borderColor = UIColor(red:0.18, green:0.26, blue:0.35, alpha:1.0).cgColor
            print ("formatting view")
        }
    }
    
    
}
