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
    var bostonDataList = [Event]()
    var fortlauderdaleDataList = [Event]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchEvent()

        self.loading.alpha  = 0
        if UserDefaults.standard.string(forKey: "logged") == nil{
            self.loading.text = "Beta"
            UIView.animate(withDuration: 2.0, delay: 0.0, options: .curveEaseOut, animations: {
                self.loading.alpha = 1.0
            })
            
          
            
        }
        
        if UserDefaults.standard.string(forKey:"logged") == "out" {
            
            self.loading.text = "Changing the world, one city a time"
            UIView.animate(withDuration: 2.0, delay: 0.0, options: .curveEaseOut, animations: {
                self.loading.alpha = 1.0
            })
            
            
        }
        
        if UserDefaults.standard.string(forKey:"token") != nil {
            self.animateText()

            ApiClient.login(token: UserDefaults.standard.string(forKey: "token")!, onCompletion: { (json) in
                print("JSON is here\(json)")
                let fullName = json["data"]["authenticateUser"]["full_name"]
                let profileURL = json["data"]["authenticateUser"]["profileImage"]["url"]
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    
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
                
              
                
                
                //self.loginSuccessful = true
                
                //performSegue(withIdentifier: "loginCompleted", sender: self)
                
            }
            
            else {
                
               // self.loading.text = "Changing the world, one city a time"
                UIView.animate(withDuration: 2.0, delay: 0.0, options: .curveEaseOut, animations: {
                    self.loading.alpha = 1.0
                })
               // self.performSegue(withIdentifier: "actionNeeded", sender: nil)
                
            }
            

            
        }
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func fetchEvent () {
            ApiClient.fetchEvents(city: "Boston",  onCompletion: { json in
                print("this is the index")
                let event = json["data"]["upcomingEvents"].array
                for (idx ,val) in (event?.enumerated())!  {
                    let event = Event(eventTitle: val["name"].stringValue, eventAddress: val["address"].stringValue , eventUsers: ["Sam"], eventDescription: val["description"].stringValue, eventDate:val["date"].stringValue, eventImageName: "brownstone", eventTime: val["time"].stringValue, eventCity: val["city"].stringValue, eventID: val["id"].int!)
                    
                    print(idx)
                    
                    if idx == 0 {
                        event.eventImage = #imageLiteral(resourceName: "brownstone")
                    }
                    
                    if idx == 1 {
                        event.eventImage = #imageLiteral(resourceName: "bostonPark")
                    }
                    
                    if idx % 2 == 0{
                        event.eventImage = #imageLiteral(resourceName: "brownstone")
                    }
                    else {
                        event.eventImage = #imageLiteral(resourceName: "bostonPark")
                        
                    }
                    
                    self.bostonDataList.append(event)
                    
                    
                    
                    
                }
            
                self.appDelegate.bostonDataList = self.bostonDataList
            })
                
        
                
                
        
        
        ApiClient.fetchEvents(city: "Fort Lauderdale",  onCompletion: { json in
            print("this is the index")
            let event = json["data"]["upcomingEvents"].array
            for (idx,val) in (event?.enumerated())!  {
                let event = Event(eventTitle: val["name"].stringValue, eventAddress: val["address"].stringValue , eventUsers: ["Sam"], eventDescription: val["description"].stringValue, eventDate:val["date"].stringValue, eventImageName: "brownstone", eventTime: val["time"].stringValue, eventCity: val["city"].stringValue, eventID: val["id"].int!)
                
                if idx == 0 {
                    event.eventImage = #imageLiteral(resourceName: "fortlauderdalepark")
                }
                
                if idx == 1 {
                    event.eventImage = #imageLiteral(resourceName: "Image1")
                }
                
                if idx % 2 == 0{
                    event.eventImage = #imageLiteral(resourceName: "fortlauderdalepark")
                }
                else {
                    event.eventImage = #imageLiteral(resourceName: "Image1")
                    
                }
                
                self.fortlauderdaleDataList.append(event)
                
                
                
            }
            self.appDelegate.fortlauderdaleDataList = self.fortlauderdaleDataList
            
            if UserDefaults.standard.string(forKey: "logged") == nil{
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "loginCompleted") as! LoginViewController
                self.show(controller, sender: nil)
                
                
            }
            
            if UserDefaults.standard.string(forKey:"logged") == "out" {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "loginCompleted") as! LoginViewController
                self.show(controller, sender: nil)
            }
            
            
            
            if UserDefaults.standard.string(forKey:"token") != nil {
                
                ApiClient.login(token: UserDefaults.standard.string(forKey: "token")!, onCompletion: { (json) in
                    print("JSON is here\(json)")
                    let fullName = json["data"]["authenticateUser"]["full_name"]
                    let profileURL = json["data"]["authenticateUser"]["profileImage"]["url"]
                    
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                        
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
            
            if UserDefaults.standard.string(forKey:"logged") == "in" && UserDefaults.standard.string(forKey: "homeCity") != nil {
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "EventViewController") as! EventViewController
                guard let city = UserDefaults.standard.string(forKey: "homeCity") else {
                    return
                }
                controller.selectedCity = city
                controller.checkMembers()
                
                //self.loginSuccessful = true
                
                self.show(controller, sender: nil)
            }
        

            
        })
        

        
        

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
