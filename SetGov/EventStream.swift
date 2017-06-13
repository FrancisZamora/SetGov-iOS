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

protocol EventStreamCallback: class {
    func refreshTap(tapped:Bool)
}


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
    var initiateStream: Bool = false
    var firstpress: Bool = true
    var EventDetailViewController:EventDetailViewController?
    @IBInspectable var startColor: UIColor = SG_RED_COLOR
    @IBInspectable var endColor: UIColor = UIColor.red
    var countDown = 0
    var presentStream: Bool = false
    var timer = Timer()
    weak var eventStreamCallback: EventStreamCallback!

    var eventTVController: EventDetailViewController?
    
    func configureColor () {
        
        buttonBackground.startColor = SG_SECONDARY_REDCOLOR
        buttonBackground.endColor = UIColor.red
              print("configuring color")
        
        
    }
    func activateStream () {
        self.initiateStream = true
    }
    
    func checkStream()-> Bool {
        if (presentStream == true) {
            return true
        }
        return false
    }
    
    func increment() {
        if countDown >= 2 {
           countDown+=1
            print("we hit increment")
        }
    }
    
    
    func streamContent() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(increment), userInfo: nil, repeats: true)
        print("streamContent initiliazing")

        if (self.initiateStream == true) {
             self.EventDetailViewController?.tableView.reloadData()
            print("reloading data")
            self.presentStream = true
            print("present Stream")
        }
        
    }
    
    
    

    
    @IBAction func buttonPressed(_ sender: Any) {
        if firstpress == true {
            self.attendButton.setTitle("Attending", for: .normal)
        }
        firstpress = false
        
        
        
        eventStreamCallback.refreshTap(tapped: true)

        
    /*
       if self.onePress == false {
        self.initiateStream = true
        self.streamContent()
        self.configureColor()
        self.pressedButton = true
        buttonBackground.startColor = SG_SECONDARY_REDCOLOR
        buttonBackground.endColor = UIColor.red
        self.EventDetailViewController?.animateView = true
        self.attendButton.setTitle("Now Live", for: .normal)
        self.buttonBackground.startColor = SG_SECONDARY_REDCOLOR
        self.buttonBackground.endColor = UIColor.red
        self.buttonBackground.backgroundColor = SG_RED_COLOR
        let transition: CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionReveal
        transition.subtype = kCATransitionFromRight
        self.buttonBackground.layer.add(transition,forKey:nil)
        self.attendButton.layer.add(transition, forKey: nil)
        self.attendButton.layer.cornerRadius = self.attendButton.frame.height / 2
        self.attendButton.clipsToBounds = true
        self.attendButton.layer.borderWidth = 1.5
        self.attendButton.layer.borderColor = UIColor(red:0.18, green:0.26, blue:0.35, alpha:0.0).cgColor
        
        if (self.pressedButton == true) {
     
            buttonBackground.startColor = SG_SECONDARY_REDCOLOR
            buttonBackground.endColor = UIColor.red
            print(buttonBackground.startColor)
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
      */
       
    }
    
    func nowLive() {
        if self.onePress == false {
            self.configureColor()
            self.pressedButton = true
            buttonBackground.startColor = SG_SECONDARY_REDCOLOR
            buttonBackground.endColor = UIColor.red
            self.EventDetailViewController?.animateView = true
            self.attendButton.setTitle("Now Live", for: .normal)
            self.buttonBackground.startColor = SG_SECONDARY_REDCOLOR
            self.buttonBackground.endColor = UIColor.red
            self.buttonBackground.backgroundColor = SG_RED_COLOR
            let transition: CATransition = CATransition()
            transition.duration = 0.5
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionReveal
            transition.subtype = kCATransitionFromRight
            self.buttonBackground.layer.add(transition,forKey:nil)
            self.attendButton.layer.add(transition, forKey: nil)
            self.attendButton.layer.cornerRadius = self.attendButton.frame.height / 2
            self.attendButton.clipsToBounds = true
            self.attendButton.layer.borderWidth = 1.5
            self.attendButton.layer.borderColor = UIColor(red:0.18, green:0.26, blue:0.35, alpha:0.0).cgColor
        
        
            buttonBackground.startColor = SG_SECONDARY_REDCOLOR
            buttonBackground.endColor = UIColor.red
            print(buttonBackground.startColor)
            print( "adding gradient")
        
        
        
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
