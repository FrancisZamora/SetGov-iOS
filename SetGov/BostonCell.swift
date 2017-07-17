//
//  BostonCell.swift
//  SetGov
//
//  Created by Francis Zamora on 4/23/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

class BostonCell: UITableViewCell {
    var activityIndicator = UIActivityIndicatorView()
    @IBOutlet var contView: UIView!
    
    func loadingAnimation() {
        activityIndicator.center = self.contView.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        contView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }

    
    
}
