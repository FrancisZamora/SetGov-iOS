//
//  City.swift
//  SetGov
//
//  Created by Balin Sinnott on 10/26/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation
import SwiftyJSON
import PromiseKit
class City: Codable {
    
    var name: String = ""
    var state: String = ""
    var isActive: Int = 0
    
    static func createCitiesFromJson(json: JSON) -> Promise<[City]> {
        
        print("creating cities from json: \(json["availableCities"])")
        
        return Promise { fulfill, reject in
            do {
                let cities = try JSONDecoder().decode([City].self, from: json["availableCities"].rawData())
                fulfill(cities)
            } catch {
                print("error during decode city: \(error.localizedDescription)")
                reject(error.localizedDescription)
            }
        }
    }
}
