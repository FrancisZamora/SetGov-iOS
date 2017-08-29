//
//  LoginViewController.swift
//  SetGov
//
//  Created by Francis Zamora on 2/27/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import SwiftyJSON
class LoginViewController: SetGovViewController, UITextFieldDelegate, LoginButtonDelegate {
    
    @IBOutlet var setGov: UIImageView!
    
    var loginSuccessful = false
    var user: User!
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
      
        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        let screenSize:CGRect = UIScreen.main.bounds
        let screenHeight = screenSize.height - 100 //real screen height
        let newCenter = CGPoint(x: view.center.x, y:screenHeight)
        loginButton.delegate = self
        loginButton.frame.size.width = 340
        loginButton.center = newCenter

        view.addSubview(loginButton)
        setGov.layer.shadowColor = UIColor.black.cgColor
        setGov.layer.shadowRadius = 2
        setGov.layer.shadowOffset = CGSize(width:-2,height:2)

        setGov.layer.shadowOpacity = 0.5
        
        self.setGov.alpha = 0
        let gesture = UITapGestureRecognizer(target: self, action: #selector(selector))
        loginButton.addGestureRecognizer(gesture)

        if let accessToken = AccessToken.current {
            UserDefaults.standard.set("in",forKey:"logged")
            UserDefaults.standard.set(accessToken.authenticationToken, forKey:"token")
            //print(accessToken)
            loginButton.isHidden = true
            if UserDefaults.standard.string(forKey: "homeCity") == nil {
                performSegue(withIdentifier: "loginCompleted", sender: self)
            }
            if UserDefaults.standard.string(forKey:"homeCity") != nil {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "EventViewController") as! EventViewController
                guard let city = UserDefaults.standard.string(forKey: "homeCity") else {
                    return
                }
                controller.selectedCity = city
                    print(accessToken)
                loginButton.isHidden = true
                
                show(controller, sender: nil)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func selector() {
        let controller = storyboard?.instantiateViewController(withIdentifier: "CityNavigationViewController") as! AgendaDetailViewController
        self.show(controller, sender: nil)
    }
    
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        if let accessToken = AccessToken.current {
            UserDefaults.standard.set(accessToken.authenticationToken, forKey:"token")
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
            
            if UserDefaults.standard.string(forKey:"homeCity") != nil {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "EventViewController") as! EventViewController
                guard let city = UserDefaults.standard.string(forKey: "homeCity") else {
                    return
                }
                controller.selectedCity = city
                //print(accessToken)
                loginButton.isHidden = true
                
                show(controller, sender: nil)
                loginSuccessful = true
            } else {
                loginButton.isHidden = true

                performSegue(withIdentifier: "loginCompleted", sender: self)
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        if loginSuccessful == true {
            performSegue(withIdentifier: "loginCompleted", sender: self)
        }
            
        UIView.animate(withDuration: 1.0, delay: 0.5, options: UIViewAnimationOptions.curveLinear, animations: {
            self.setGov.alpha = 1.0
        }, completion: nil)
            
    }

    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        return
    }
}
