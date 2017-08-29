//
//  SetGovViewController.swift
//  SetGov
//
//  Created by Francis Zamora on 2/27/17.
//  Copyright ©  2017 Stredm.. All rights reserved.
//

import Foundation
import UIKit

class SetGovViewController: UIViewController {
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

       // ApiClient.login(onCompletion: { value in
         //   print(value)
        //,})
        
        print("login response")

        if  Reachability.isConnectedToNetwork() == true {
            print("Internet connection OK")
        } else {
            print("Internet connection FAILED")
            let alert = UIAlertView(title: "No Internet Connection", message: "Your device is not connected to the internet, SetGov will not work.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }

        /*
         * NAVIGATION BAR
         */
        // set blue header
        //        self.navigationController?.navigationBar.barTintColor = SM_PRIMARY_COLOR
        // set white title
        self.navigationController?.navigationBar.tintColor = SG_NEARLY_WHITE_COLOR
        // make bar opaque
        self.navigationController?.navigationBar.barStyle = .black
        // make back arrows have no titles
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        
        /*
         * BACKGROUND
         */
        
        self.view.backgroundColor = SG_NEARLY_WHITE_COLOR
        self.setNeedsStatusBarAppearanceUpdate()
    }
}
