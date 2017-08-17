//
//  SettingsTableViewController.swift
//  SetGov
//
//  Created by Francis Zamora on 7/7/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation
import UIKit

class SettingsTableViewController: SetGovTableViewController, LogOutCallBack {
    var numsections = 0
    var pickerData: [String] = [String]()
    var user: User!

    @IBOutlet var rightbarItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = nil

    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let city = UserDefaults.standard.string(forKey: "homeCity") {
            ApiClient.setHomeCity(city: city)
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func loggingOut(){
        performSegue(withIdentifier:"logOut", sender: nil)
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
        return 3
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        let screenSize: CGRect = UIScreen.main.bounds

        switch indexPath.row {
        case 0:
            return 0.74 * screenSize.height
        case 1:
            return 0.081 * screenSize.height
        case 2:
            return 0.081 * screenSize.height
        case 3:
            return 0.080 * screenSize.height
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row == 0) {
            let cell =  tableView.dequeueReusableCell(withIdentifier: "profileCell") as! profileCell
            cell.selectionStyle = .none
            cell.user = self.appDelegate.user
            cell.configure()
            return cell
        }
        
        
        if (indexPath.row == 1) {
            
            let cell =  tableView.dequeueReusableCell(withIdentifier: "homeCity") as! homeCity
            cell.selectionStyle = .none
            cell.configurePicker()
            
            return cell
        
        }
        
        if (indexPath.row == 2) {
        
            let cell =  tableView.dequeueReusableCell(withIdentifier: "logOut") as! logOut
            cell.selectionStyle = .none
            cell.createButton()
            cell.logoutcallBack = self

            
            return cell
        
        }
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "logOut") as! logOut
        return cell
    }
    
    
}
