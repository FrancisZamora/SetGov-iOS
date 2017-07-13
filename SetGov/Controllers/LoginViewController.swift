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
class LoginViewController: SetGovViewController, UITextFieldDelegate, LoginButtonDelegate {
    @IBOutlet var LoginField: UITextField!
    
    @IBOutlet var Login: UIButton!
    @IBOutlet var PassField: UITextField!
    var loginSuccessful = false
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        loginButton.center = view.center
        view.addSubview(loginButton)
        loginButton.delegate = self
        

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
    }
    
    
    
    
    func selector() {
        let controller = storyboard?.instantiateViewController(withIdentifier: "CityNavigationViewController") as! AgendaDetailViewController
        self.show(controller, sender: nil)
    }
    
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
            loginSuccessful = true

        }
    
    
    
    
        override func viewDidAppear(_ animated: Bool) {
            if loginSuccessful == true {
                performSegue(withIdentifier: "loginCompleted", sender: self)
            }
            
        }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            return
        }
        print(identifier)
    }
    
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        return
    }
    
        //UIView.animateWithDuration(1.5, delay: 1.5, options: UIViewAnimationOptions.CurveLinear, animations: {
        //self.SSImage.alpha = 1.0
        //}, completion: nil)
        //}


  /* func textFieldShouldReturn(_ LoginField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
 */

}

