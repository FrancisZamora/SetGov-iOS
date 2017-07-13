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
        loginButton.center = contView.center
        contView.addSubview(loginButton)

        
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        print("logging out")
        
        if let callBack = logoutcallBack {
            callBack.loggingOut()
        }
        return
    }
    
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        return

    }
}
