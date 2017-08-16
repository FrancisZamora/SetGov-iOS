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
    var user: User!

    @IBOutlet var pickerView: UIPickerView!
    
    func configurePicker() {
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        if UserDefaults.standard.string(forKey: "homeCity")! == "Boston" {
            pickerData = ["Boston","Fort Lauderdale"]
        }
        else  {
            pickerData = ["Fort Lauderdale","Boston"]
        }
    
    }
    
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return  1
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var label = view as! UILabel!
        if label == nil {
            label = UILabel()
        }
        
        let data = pickerData[row]
        let title = NSAttributedString(string: data, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 17, weight: UIFontWeightRegular)])
        label?.attributedText = title
        label?.textAlignment = .center
        return label!
        
    }
    
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(pickerData[row])
        
        UserDefaults.standard.set(pickerData[row],forKey:"homeCity")
        ApiClient.setHomeCity(city:pickerData[row])

        print(UserDefaults.standard.string(forKey: "homeCity")!)
        
        
        
        
        //always direct to home city
    }





}
