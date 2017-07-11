//
//  homeCity.swift
//  SetGov
//
//  Created by Francis Zamora on 7/7/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation
import UIKit

class homeCity: UITableViewCell,UIPickerViewDelegate, UIPickerViewDataSource {
    var pickerData: [String] = [String]()

   

    @IBOutlet var pickerView: UIPickerView!
    
    func configurePicker() {
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        pickerData = ["Boston","Fort Lauderdale","New York City", "Miami"]
        
    }
    
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return  1
    }

    
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }






}
