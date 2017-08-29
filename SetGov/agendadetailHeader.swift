//
//  AgendaDetailHeader.swift
//  SetGov
//
//  Created by Francis Zamora on 4/6/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

protocol HeaderCallBack: class {
    func dismissView()
}

class AgendaDetailHeader: UITableViewCell {
    
    @IBOutlet var agendaImage: UIImageView!
    @IBOutlet var secondaryTitle: UILabel!
    @IBOutlet var tertiaryTitle: UILabel!
    @IBOutlet var exitButton: UIButton!
    weak var headerCallBack: HeaderCallBack!

    @IBAction func buttonPressed(_ sender: Any) {
        if let callback = headerCallBack {
            callback.dismissView()
        }
    }
    
    func configure(agenda: Agenda) {
        selectionStyle = .none
    }
}
