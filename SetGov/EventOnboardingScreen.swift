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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.background.alpha = 0.5
        
        self.background.backgroundColor = .gray
        gotIt.layer.cornerRadius = 5

    }
    @IBAction func buttonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: {})

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    
    
    
    

    
}
