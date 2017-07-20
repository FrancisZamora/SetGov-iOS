//
//  SplashViewController.swift
//  SetGov
//
//  Created by Francis Zamora on 7/19/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView


class SplashViewController: SetGovViewController {
    @IBOutlet var animationView: NVActivityIndicatorView!
    @IBOutlet var loading: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        loading.alpha = 0
        self.animationView.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 6) {
            self.animationView.stopAnimating()
        }
        
        self.animateText()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    func animateText() {
        
        loading.alpha = 1
        UIView.animate(withDuration: 2.0, delay: 0.0, options: .curveEaseOut, animations: {
            self.loading.alpha = 1.0
        })
        
        
        
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.loading.alpha  = 0
            UIView.animate(withDuration: 2.0, delay: 0.0, options: .curveEaseOut, animations: {
                self.loading.alpha = 1.0
                })
            }
        
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.loading.alpha  = 0
            UIView.animate(withDuration: 2.0, delay: 0.0, options: .curveEaseOut, animations: {
                self.loading.alpha = 1.0
            })
        }

        
        
    }
    
    
   
    
}
