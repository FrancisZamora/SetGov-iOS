//
//  homeCity.swift
//  SetGov
//
//  Created by Francis Zamora on 7/7/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation
import UIKit

protocol HomeCityCallBack: class {
    func popView(city:String)
    
}

class homeCity: UITableViewCell,UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    var pickerData: [String] = [String]()
    var user: User!
    weak var homecitycallBack: HomeCityCallBack!


    @IBOutlet var pickerTextField: UITextField!
    @IBOutlet var pickerView: UIPickerView!
    
    @IBOutlet var homeCity: UILabel!
    func configurePicker() {
        homeCity.text = UserDefaults.standard.string(forKey: "homeCity")
        pickerTextField.delegate = self
        
        let pickerView = UIPickerView()

        pickerTextField.borderStyle = .none
        pickerTextField.inputView = pickerView
        
        pickerView.showsSelectionIndicator = true
        pickerView.delegate = self
        pickerView.dataSource = self
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        
        
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action:#selector(donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self,  action:#selector(donePicker))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        

        
        
        pickerTextField.inputAccessoryView = toolBar
        
        
   
        
        
        pickerView.delegate = self
        pickerView.dataSource = self
        if UserDefaults.standard.string(forKey: "homeCity")! == "Boston" {
            pickerData = ["Boston","Fort Lauderdale"]
        }
        else  {
            pickerData = ["Fort Lauderdale","Boston"]
        }
        
        
    }
    
    func donePicker (sender:UIBarButtonItem)
    {
        pickerTextField.resignFirstResponder()
    }
    
   
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return  1
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
   // func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
     //   pickerTextField.resignFirstResponder()
       // return false
    //}
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
        //print(pickerData[row])
        homeCity.text = UserDefaults.standard.string(forKey: "homeCity")

        pickerTextField.text = "Change my city"
        
        UserDefaults.standard.set(pickerData[row],forKey:"homeCity")
        homeCity.text = UserDefaults.standard.string(forKey: "homeCity")
        print(homeCity.text)
        ApiClient.setHomeCity(city:pickerData[row])
        
        if let callback = homecitycallBack {
            
            callback.popView(city: pickerData[row])
        }
        //print(UserDefaults.standard.string(forKey: "homeCity")!)
        
        //always direct to home city
    }
}
