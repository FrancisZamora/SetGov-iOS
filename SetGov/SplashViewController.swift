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
import Kanna

class SplashViewController: SetGovViewController {
    @IBOutlet var animationView: NVActivityIndicatorView!
    @IBOutlet var loading: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.animationView.startAnimating()
        
        ApiClient.fetchCities()
            .then { cities -> Void  in
                print("got cities: \(cities)")
                self.appDelegate.cities = cities
                self.checkIfComplete()
            }.catch { error in
                print("Error during fetch cities:\(error.localizedDescription)")
            }
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func checkIfComplete() {
        
        let logged = UserDefaults.standard.string(forKey: "logged")
        
        if logged == nil || logged == "out" {
            print("going to login")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "loginCompleted") as! LoginViewController
            self.show(controller, sender: nil)
            
        } else if UserDefaults.standard.string(forKey:"token") != nil {
            print("found token")
            ApiClient.login(token: UserDefaults.standard.string(forKey: "token")!, onCompletion: { (json) in
                //print("JSON is here\(json)")
                let fullName = json["data"]["authenticateUser"]["full_name"]
                let profileURL = json["data"]["authenticateUser"]["profileImage"]["url"]
                
                DispatchQueue.main.async() {
                    
                    guard let name = fullName.string else {
                        return
                    }
                    guard let fbpID = profileURL.string else {
                        return
                    }
                    
                    self.appDelegate.user.fullName = name
                    self.appDelegate.user.profilePictureURL = fbpID
                    
                    
                    if let city = UserDefaults.standard.string(forKey: "homeCity") {
                        print("found city: \(city)")
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let controller = storyboard.instantiateViewController(withIdentifier: "EventViewController") as! EventViewController
                        controller.selectedCity = city
                        self.navigationController?.pushViewController(controller, animated: true)
                        //show(controller, sender: nil)
                    } else {
                        print("no city found")
                        self.performSegue(withIdentifier: "chooseCity", sender: self)
                    }
                }
            })
        }
        
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
