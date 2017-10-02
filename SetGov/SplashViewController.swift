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
    var user: User!
    var bostonDataList = [Event]()
    var fortlauderdaleDataList = [Event]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "EventViewController") as! EventViewController
              controller.checkMembers()
        
        //self.loginSuccessful = true
        
        self.show(controller, sender: nil)
        self.fortlauderdaleLinks()

        if let date = UserDefaults.standard.object(forKey: "parsed") as? Date {

            if(date.timeIntervalSinceNow < -64800) {
                //parseEvents()
            } else {
                fetchEvents()
            }
        } else {
            //parseEvents()
        }
        
        if UserDefaults.standard.string(forKey:"token") != nil {
            self.animateText()

            ApiClient.login(token: UserDefaults.standard.string(forKey: "token")!, onCompletion: { (json) in
                //print("JSON is here\(json)")
                let fullName = json["data"]["authenticateUser"]["full_name"]
                let profileURL = json["data"]["authenticateUser"]["profileImage"]["url"]
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    guard let name = fullName.string else {
                        return
                    }
                    guard let fbpID = profileURL.string else {
                        return
                    }
                    
                    //print(name)
                    //print(fbpID)
                    self.user = User(fullName: name, profilePictureURL: fbpID)
                    self.appDelegate.user = self.user
                }
            })
        } else {
            
        }
        self.animationView.startAnimating()
    }
    
    func parseEvents() {
        WebScraper.parseEvents(onCompletion: {
            UserDefaults.standard.setValue(Date(), forKey: "parsed")
            self.fetchEvents()
        })
    }
    
    func fortlauderdaleLinks() {
        let url = URL(string: "https://fortlauderdale.legistar.com/Calendar.aspx")
        guard let doc = HTML(url: url!, encoding: .utf8) else  {
            return
        }
        var linkArray = [String]()
        for links in doc.css(".videolink") {
            let rawlink =  links["onclick"]?.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let extractArray = rawlink?.components(separatedBy: "window.open(\'")
            let newString = extractArray?[1]
            var newStringArray = newString?.components(separatedBy: "\'")
            guard let  editedString = newStringArray?[0] else {
                break
            }
            var editedArray = editedString.components(separatedBy: "ID1=")
            let preID = editedArray[1]
            var prematureArray = preID.components(separatedBy:"&")
            let id  = prematureArray[0]
            
            linkArray.append(id)
            appDelegate.fortlauderdaleStreams = linkArray
            
        }
        //loop through numbers 
        for href in doc.css("#ctl00_ContentPlaceHolder1_gridCalendar_ctl00_ctl32_hypAgenda") {
            print("recognized html tag")
            guard let rawData = href["href"]?.trimmingCharacters(in: .whitespacesAndNewlines) else {
                continue
            }
            let rawDataArray = rawData.components(separatedBy: "View.ashx?M=A&ID=")
            let newData = rawDataArray[1]
            let newDataArray = newData.components(separatedBy: "&GUI")
            let soughtData = newDataArray[0]
            print(soughtData)
            print("getting data")
            
            appDelegate.fortlauderdalePDFLinks.append(rawData)
          
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func checkIfComplete() {
 

        if(bostonDataList.count > 0 && fortlauderdaleDataList.count > 0) {
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
                    //print("JSON is here\(json)")
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
                        
                        //print(name)
                        //print(fbpID)
                        
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
        }
    }
    
    func fetchEvents () {
        ApiClient.fetchEvents(city: "Boston",  onCompletion: { events  in
            for event in events {
                //print("EVENT NAME: \(event.title)")
                //print("AGENDA: \(event.agendaItems)")
            }
            self.bostonDataList = events
            self.appDelegate.bostonDataList = self.bostonDataList
            self.checkIfComplete()
        })
        
        ApiClient.fetchEvents(city: "Fort Lauderdale",  onCompletion: { event in
            //print("this is the index")
            self.fortlauderdaleDataList = event
            self.appDelegate.fortlauderdaleDataList = self.fortlauderdaleDataList
            self.checkIfComplete()
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
