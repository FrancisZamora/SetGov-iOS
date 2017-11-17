//
//  AgendaCell.swift
//  SetGov
//
//  Created by Francis Zamora on 3/28/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

class AgendaCell: UICollectionViewCell {
    
    @IBOutlet weak var mLabel: UILabel!
    @IBOutlet weak var mBackground: UIView!
    
    override func awakeFromNib() {
        mBackground.layer.cornerRadius = 5
        mBackground.layer.borderColor = UIColor.black.cgColor
        mBackground.layer.borderWidth = 1
        
    }
    
    
    func configureCell(agenda: Agenda) {
        
        mLabel.text = agenda.name
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
}
