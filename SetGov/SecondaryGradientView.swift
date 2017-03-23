//
//  SecondaryGradientView.swift
//  SetGov
//
//  Created by Francis Zamora on 3/23/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation
import Foundation
import UIKit
@IBDesignable final class SecondaryGradientView: UIView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("req inti RoundedFloatingImageButton")
        self.layer.cornerRadius = self.frame.height/2
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
        self.layer.masksToBounds = false
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    @IBInspectable var startColor: UIColor = UIColor.blue
    @IBInspectable var endColor: UIColor = SG_SECONDARY_BLUECOLOR
    
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

