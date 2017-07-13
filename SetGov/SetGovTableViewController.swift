//
//  SetGovTableViewController.swift
//  SetGov
//
//  Created by Francis Zamora on 3/6/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation
import UIKit

class SetGovTableViewController: UITableViewController {
    
     var appDelegate = UIApplication.shared.delegate as! AppDelegate



    override func viewDidLoad() {
        super.viewDidLoad()
        
        if  Reachability.isConnectedToNetwork() == true {
            print("Internet connection OK")
        } else {
            print("Internet connection FAILED")
            let alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }


    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
           
    func setupAppearanceAndRefreshControl() {
        self.tableView.backgroundColor = SG_NEARLY_WHITE_COLOR
    }
        
    
    
}
