//
//  GeneralHelper.swift
//  SetGov
//
//  Created by Balin Sinnott on 10/26/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation
import SwiftyJSON
import PromiseKit

class GeneralHelper {
    
    static func createJson(json: Any) -> Promise<JSON> {
        
        return Promise { fulfill, reject in
            
            let json = JSON(json)
            if(json["errors"].exists()) {
                print("error creating JSON: \(json["errors"][0]["message"].string!)")
                reject ("Error creating JSON!")
                return
            }
            
            fulfill(json["data"])
        }
    }
}
