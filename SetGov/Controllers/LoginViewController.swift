//
//  ViewController.swift
//  SetGov
//
//  Created by Francis Zamora on 2/27/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import UIKit
import FacebookLogin
class LoginViewController: SetGovViewController, UITextFieldDelegate {
    @IBOutlet var LoginField: UITextField!
    
    @IBOutlet var PassField: UITextField!
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        LoginField.delegate = self
        PassField.delegate = self
        
        super.viewDidLoad()
       
        LoginField.center.y = self.view.frame.height + 30
        UIView.animate(withDuration: 1.0, delay: 0.5, usingSpringWithDamping: 1.5, initialSpringVelocity: 5.0, options: UIViewAnimationOptions.curveLinear, animations: { () -> Void in
            self.LoginField.center.y = self.view.frame.width / CGFloat(3.0)
        }) { (completed) -> Void in }
        
        PassField.center.y = self.view.frame.height + 30
        UIView.animate(withDuration: 1.0, delay: 0.6, usingSpringWithDamping: 1.5, initialSpringVelocity: 5.0, options: UIViewAnimationOptions.curveLinear, animations: { () -> Void in
            self.PassField.center.y = self.view.frame.width / CGFloat(3.0)
        }) { (completed) -> Void in }
        
        LoginButton.center.y = self.view.frame.height + 30
        UIView.animate(withDuration: 1.0, delay: 0.7, usingSpringWithDamping: 1.5, initialSpringVelocity: 5.0, options: UIViewAnimationOptions.curveLinear, animations: { () -> Void in
            self.LoginButton.center.y = self.view.frame.width / CGFloat(3.0)
        }) { (completed) -> Void in }
        
      

        // Do any additional setup after loading the view, typically from a nib.
    }
       
        //UIView.animateWithDuration(1.5, delay: 1.5, options: UIViewAnimationOptions.CurveLinear, animations: {
        //self.SSImage.alpha = 1.0
        //}, completion: nil)
        //}


   func textFieldShouldReturn(_ LoginField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }

}

