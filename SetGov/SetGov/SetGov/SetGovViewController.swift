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
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        self.view.backgroundColor = SG_DARK_GRAY_COLOR
        
        self.setNeedsStatusBarAppearanceUpdate()
    }
}
