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
    
    @IBOutlet var topicLabel: UILabel!
    
    @IBOutlet var agendaPic: UIImageView!
    
    func configureCell(agenda: Agenda) {
        
        mLabel.text = agenda.name
        topicLabel.text = agenda.description
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
}
