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
        
        
        //fade in from zero
        self.setGov.alpha = 0
        let gesture = UITapGestureRecognizer(target: self, action: #selector(selector))
        loginButton.addGestureRecognizer(gesture)
        
        /*
        LoginField.delegate = self
        PassField.delegate = self
        let myLoginButton = UIButton(type: .custom)
        myLoginButton.backgroundColor = UIColor.darkGray
        myLoginButton.frame.origin.y = 500
        myLoginButton.setTitle("My Login Button", for: .normal)
        
        // Handle clicks on the button
       
        
        // Add the button to the view
        view.addSubview(myLoginButton)
        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        loginButton.center = view.center
        
        view.addSubview(loginButton)
        
        super.viewDidLoad()
       
        LoginField.center.y = self.view.frame.height + 30
        UIView.animate(withDuration: 1.0, delay: 0.5, usingSpringWithDamping: 1.5, initialSpringVelocity: 5.0, options: UIViewAnimationOptions.curveLinear, animations: { () -> Void in
            self.LoginField.center.y = self.view.frame.width / CGFloat(3.0)
        }) { (completed) -> Void in }
        
        PassField.center.y = self.view.frame.height + 30
        UIView.animate(withDuration: 1.0, delay: 0.6, usingSpringWithDamping: 1.5, initialSpringVelocity: 5.0, options: UIViewAnimationOptions.curveLinear, animations: { () -> Void in
            self.PassField.center.y = self.view.frame.width / CGFloat(3.0)
        }) { (completed) -> Void in }
        
        Login.center.y = self.view.frame.height + 30
        UIView.animate(withDuration: 1.0, delay: 0.7, usingSpringWithDamping: 1.5, initialSpringVelocity: 5.0, options: UIViewAnimationOptions.curveLinear, animations: { () -> Void in
            self.Login.center.y = self.view.frame.width / CGFloat(3.0)
        }) { (completed) -> Void in }
        
      
        */
        // Do any additional setup after loading the view, typically from a nib.
        if let accessToken = AccessToken.current {
            print(accessToken)
         //   self.loginSuccessful = true
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
                //controller.selectedCity = UserDefaults.standard.string(forKey: "homeCity")!
                    print(accessToken)
                    //self.loginSuccessful = true
                loginButton.isHidden = true
                
                show(controller, sender: nil)
                
                //performSegue(withIdentifier: "loginCompleted", sender: self)

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
//            ApiClient.login( token:String(describing: accessToken), onCompletion: { json in
//                
//            })
            ApiClient.login(token: accessToken.authenticationToken, onCompletion: { (json) in
                print("JSON is here\(json)")
                
                let profileID = json["data"]["authenticateUser"]["profileImage"]["url"]
                print(profileID)
                

                
                
            })
            
            
            
            loginSuccessful = true
            loginButton.isHidden = true

            performSegue(withIdentifier: "loginCompleted", sender: self)

            print("swag")
            
        }

    }
    
    
    
    
        override func viewDidAppear(_ animated: Bool) {
            
            if loginSuccessful == true {

                performSegue(withIdentifier: "loginCompleted", sender: self)
            }
            
            UIView.animate(withDuration: 1.5, delay: 1.5, options: UIViewAnimationOptions.curveLinear, animations: {
                self.setGov.alpha = 1.0
            }, completion: nil)
            
        }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            return
        }
    }
    
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        return
    }
    
  
}

