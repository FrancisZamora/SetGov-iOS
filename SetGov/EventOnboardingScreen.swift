//
//  EventOnboardingScreen.swift
//  SetGov
//
//  Created by Francis Zamora on 7/11/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation
import UIKit

class EventOnboardingScreen: SetGovViewController{
        @IBOutlet var background: UIView!
        @IBOutlet var gotIt: UIButton!
        @IBOutlet var textBlock: UILabel!
        @IBOutlet var discover: UILabel!
        @IBOutlet var icon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        background.backgroundColor =  UIColor.black.withAlphaComponent(0.4)
        gotIt.layer.cornerRadius = 5

    }
    @IBAction func buttonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: {})

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    
    
    
    

    
}
