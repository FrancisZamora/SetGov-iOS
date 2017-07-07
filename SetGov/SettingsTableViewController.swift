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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
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
        switch indexPath.row {
        case 0:
            return 200
        case 1:
            return 38
        case 2:
            return 176
        default:
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row == 0) {
            let cell =  tableView.dequeueReusableCell(withIdentifier: "profileCell") as! profileCell
            return cell
        }
        
        if (indexPath.row == 1) {
            
            let cell =  tableView.dequeueReusableCell(withIdentifier: "pushNotification") as! pushNotification
            return cell
        }
        
        if (indexPath.row == 2) {
            
            let cell =  tableView.dequeueReusableCell(withIdentifier: "homeCity") as! homeCity
            return cell
        
        }
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "homeCity") as! homeCity
        return cell
        
        
    }
    
    
}
