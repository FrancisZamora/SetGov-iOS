//
//  SettingsTableViewController.swift
//  SetGov
//
//  Created by Francis Zamora on 7/7/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation
import UIKit

class SettingsTableViewController: SetGovTableViewController {
    var numsections = 0
    var pickerData: [String] = [String]()


    @IBOutlet var rightbarItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = nil

    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    

    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        self.numsections = 1
        print("numberofSections")
        return 1
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
    
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        switch indexPath.row {
        case 0:
            return 435
        case 1:
            return 69
        case 2:
            return 69
        case 3:
            return 69
        default:
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row == 0) {
            let cell =  tableView.dequeueReusableCell(withIdentifier: "profileCell") as! profileCell
            cell.selectionStyle = .none
            return cell
        }
        
        if (indexPath.row == 1) {
            
            let cell =  tableView.dequeueReusableCell(withIdentifier: "pushNotification") as! pushNotification
            cell.selectionStyle = .none
            
            if self.appDelegate.francis.pushNotifications == true {
                cell.pushSwitch.isOn = true
            }
            else {
                cell.pushSwitch.isOn = false
            }
            
            return cell
        }
        
        if (indexPath.row == 2) {
            
            let cell =  tableView.dequeueReusableCell(withIdentifier: "homeCity") as! homeCity
            cell.selectionStyle = .none
            cell.configurePicker()
            cell.francis = self.appDelegate.francis
            return cell
        
        }
        
        if (indexPath.row == 3) {
        
            let cell =  tableView.dequeueReusableCell(withIdentifier: "logOut") as! logOut
            cell.selectionStyle = .none
            cell.createButton()
            
            return cell
        
        }
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "logOut") as! logOut
        return cell
    }
    
    
}
