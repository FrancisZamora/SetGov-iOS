//
//  logOut.swift
//  SetGov
//
//  Created by Francis Zamora on 7/7/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation
import UIKit
import FacebookCore
import FacebookLogin

protocol LogOutCallBack: class {
    func loggingOut()
}

class logOut: UITableViewCell, LoginButtonDelegate {
    @IBOutlet var contView: UIView!
    weak var logoutcallBack: LogOutCallBack!
    
    func createButton() {
        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        loginButton.delegate = self
        let screenSize: CGRect = UIScreen.main.bounds

        loginButton.frame.size.width = screenSize.width - 80
        loginButton.center = contView.center 
        contView.addSubview(loginButton)
        if let callBack = logoutcallBack {
            callBack.loggingOut()
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        print("logging out")
        UserDefaults.standard.set(nil, forKey: "token")
        if let callBack = logoutcallBack {
            callBack.loggingOut()
            UserDefaults.standard.set("out",forKey:"logged")
        }
        return
    }
    
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        return
    }
}
