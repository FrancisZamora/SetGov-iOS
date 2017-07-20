//
//  SplashViewController.swift
//  SetGov
//
//  Created by Francis Zamora on 7/19/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper
import NVActivityIndicatorView
import SwiftyJSON

class SplashViewController: SetGovViewController {
    @IBOutlet var animationView: NVActivityIndicatorView!
    @IBOutlet var loading: UILabel!
    var user: User!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loading.alpha  = 0
        

        if UserDefaults.standard.string(forKey:"logged") == "out" {
            self.loading.text = "Changing the world, one city a time"
            UIView.animate(withDuration: 2.0, delay: 0.0, options: .curveEaseOut, animations: {
                self.loading.alpha = 1.0
            })
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {

                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "loginCompleted") as! LoginViewController
                self.show(controller, sender: nil)
            }
            
        }
        
        if UserDefaults.standard.string(forKey:"token") != nil {
            self.animateText()

            ApiClient.login(token: UserDefaults.standard.string(forKey: "token")!, onCompletion: { (json) in
                print("JSON is here\(json)")
                let fullName = json["data"]["authenticateUser"]["full_name"]
                let profileURL = json["data"]["authenticateUser"]["profileImage"]["url"]
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    print(fullName.string)
                    print(profileURL.string)
                    self.user = self.appDelegate.user

                    guard let name = fullName.string else {
                        return
                    }
                    guard let fbpID = profileURL.string else {
                        return
                    }
                    
                    print(name)
                    print(fbpID)
                    
                    self.user.fullName = name
                    self.user.profilePictureURL = fbpID
                    
                }
                
            })
            
        
            
        }
        self.animationView.startAnimating()

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.animationView.stopAnimating()
            if UserDefaults.standard.string(forKey:"logged") == "in" && UserDefaults.standard.string(forKey: "homeCity") != nil {
                self.loading.text = "Loading"
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
                
                //self.loading.text = "Changing the world, one city a time"
                //UIView.animate(withDuration: 2.0, delay: 0.0, options: .curveEaseOut, animations: {
                    self.loading.alpha = 1.0
                //})
              //  self.performSegue(withIdentifier: "actionNeeded", sender: nil)
                
            }
            

            
        }
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    func animateText() {
        if UserDefaults.standard.string(forKey:"token") != nil {
      
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
                self.loading.alpha  = 0
                UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {
                    self.loading.alpha = 1.0
                })
            }

        
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
                self.loading.alpha  = 0
                UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {
                    self.loading.alpha = 1.0
                    })
                }
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0) {
                self.loading.alpha  = 0
                UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {
                    self.loading.alpha = 1.0
                })
            }
        
        }

        
        
        
        
    }
    
    
    
   
    
}
