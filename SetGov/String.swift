//
//  String.swift
//  SetGov
//
//  Created by Balin Sinnott on 10/26/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation
extension String: LocalizedError {
    
    //pass strings as an error.  Access message via error.localizedDescription
    public var errorDescription: String? { return self }
}
