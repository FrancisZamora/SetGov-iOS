//
//  GradientView.swift
//  SetGov
//
//  Created by Francis Zamora on 3/17/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation
import UIKit
@IBDesignable final class GradientView: UIView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("req inti RoundedFloatingImageButton")
        self.layer.cornerRadius = self.frame.height/2
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
        self.layer.masksToBounds = false
        print ("yo")
    }

    
    @IBInspectable var startColor: UIColor = SG_RED_COLOR
    @IBInspectable var endColor: UIColor = UIColor.red
    
    override func draw(_ rect: CGRect) {
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = rect
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        gradient.zPosition = -1
        layer.addSublayer(gradient)
    }
}
