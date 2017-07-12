//
//  CityOnboardingScreen.swift
//  SetGov
//
//  Created by Francis Zamora on 7/11/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation
import UIKit

class CityOnboardingScreen: SetGovViewController{
    
    @IBOutlet var gotIt: UIButton!
    
    @IBAction func gotItAction(_ sender: Any) {
        self.dismiss(animated: false, completion: {})
    }
    
}
