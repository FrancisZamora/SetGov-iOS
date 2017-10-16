//
//  AttendCell.swift
//  SetGov
//
//  Created by Francis Zamora on 10/16/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation
import UIKit
protocol AttendCellCallBack: class {
    func attendbuttonTapped()
}
class AttendCell: UITableViewCell {
    @IBOutlet var attendButton: UIButton!
    weak var AttendCellCallBack: AttendCellCallBack!
    @IBAction func attendAction(_ sender: Any) {
        attendButton.setTitle("ATTENDING", for: .normal)
        if let callback = self.AttendCellCallBack {
            callback.attendbuttonTapped()
        }
    }
}
