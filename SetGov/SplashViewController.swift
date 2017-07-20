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
       
        self.loading.alpha  = 0
   
    
        self.animationView.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 6) {
            self.animationView.stopAnimating()
            
            if UserDefaults.standard.string(forKey:"loggedIn") == "in" {
                UIView.animate(withDuration: 2.0, delay: 0.0, options: .curveEaseOut, animations: {
                    self.loading.alpha = 1.0
                })
                

                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "EventViewController") as! EventViewController
                guard let city = UserDefaults.standard.string(forKey: "homeCity") else {
                    return
                }
                controller.selectedCity = city
                //self.loginSuccessful = true
                
                self.show(controller, sender: nil)
                //performSegue(withIdentifier: "loginCompleted", sender: self)
                
            }
            
            else {
                self.loading.isHidden = true
                self.performSegue(withIdentifier: "actionNeeded", sender: nil)
                
            }
            

            
        }
        
        self.animateText()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    func animateText() {
        if UserDefaults.standard.string(forKey:"loggedIn") == "in" {

      
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
                self.loading.alpha  = 0
                UIView.animate(withDuration: 3.0, delay: 0.0, options: .curveEaseOut, animations: {
                    self.loading.alpha = 1.0
                })
            }

        
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4.5) {
                self.loading.alpha  = 0
                UIView.animate(withDuration: 3.0, delay: 0.0, options: .curveEaseOut, animations: {
                    self.loading.alpha = 1.0
                    })
                }
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 7.5) {
                self.loading.alpha  = 0
                UIView.animate(withDuration: 3.0, delay: 0.0, options: .curveEaseOut, animations: {
                    self.loading.alpha = 1.0
                })
            }
        
        }

        
        
        
        
    }
    
    
    
   
    
}
