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
    
    static func getLocalTime(dateString: String) -> String {
        
        print("get local time: \(dateString)")
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "h:mma"
        
        let date: Date? = dateFormatterGet.date(from: dateString)
        if let d = date {
            print("created new string")
            print("USING DATE: \(d)")
            return dateFormatterPrint.string(from: d)
        }
        print("using old string")
        return dateString
    }
}
