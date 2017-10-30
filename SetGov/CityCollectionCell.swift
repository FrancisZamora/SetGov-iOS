//
//  CityCollectionCell.swift
//  SetGov
//
//  Created by Balin Sinnott on 10/26/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation
import UIKit

class CityCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var mBackgroundImage: UIImageView!
    @IBOutlet weak var mState: UILabel!
    @IBOutlet weak var mCity: UILabel!
    @IBOutlet weak var mBlurView: UIView!
    @IBOutlet weak var mBlurLabel: UILabel!
    
    func configure(city: City) {
        
        mState.text = city.state
        mCity.text = city.name
        if(city.isActive == 0) {
            mBlurView.alpha = 0.65
            mBlurLabel.isHidden = false
        } else {
            mBlurView.alpha = 0.20
            mBlurLabel.isHidden = true
            contentView.bringSubview(toFront: mCity)
            contentView.bringSubview(toFront: mState)

        }
        
        switch city.name {
        case "Boston":
            mBackgroundImage.image = #imageLiteral(resourceName: "Image-9")
            break
        case "Fort Lauderdale":
            mBackgroundImage.image = #imageLiteral(resourceName: "Image-11")
            break
        case "Phoenix":
            mBackgroundImage.image = #imageLiteral(resourceName: "Image-35")
            break
        case "Miami":
            mBackgroundImage.image = #imageLiteral(resourceName: "miami")
            break
        case "Austin":
            mBackgroundImage.image = #imageLiteral(resourceName: "Image-36")
            break
        case "San Jose":
            mBackgroundImage.image = #imageLiteral(resourceName: "Image-37")
            break
        default:
            break
        }
        
        
    }
    
}
