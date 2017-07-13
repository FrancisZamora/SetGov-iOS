//
//  CityOnboardingScreen.swift
//  SetGov
//
//  Created by Francis Zamora on 7/11/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation
import UIKit
import FacebookLogin
import FacebookCore

class CityOnboardingScreen: SetGovViewController{
    
    @IBOutlet var gotIt: UIButton!
    @IBOutlet var engage: UILabel!
    @IBOutlet var icon: UIImageView!
    @IBOutlet var textBlock: UILabel!
    @IBOutlet var background: UIView!
    
    override func viewDidLoad() {
       
         super.viewDidLoad()
        self.background.alpha = 0.5
        self.gotIt.alpha = 1
        
        self.background.backgroundColor = .gray
          
        // self.background.backgroundColor = UIColor.black.withAlphaComponent(0.8)
         gotIt.layer.cornerRadius = 5
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    @IBAction func gotItAction(_ sender: Any) {
        self.dismiss(animated: true, completion: {})
    }
    
}
