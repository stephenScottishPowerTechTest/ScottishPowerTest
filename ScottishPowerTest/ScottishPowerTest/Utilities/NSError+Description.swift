//
//  NSError+Description.swift
//  ScottishPowerTest
//
//  Created by Stephen Biggerstaff on 01/03/2020.
//  Copyright © 2020 Stephen. All rights reserved.
//

import Foundation

extension NSError {
    
    class func error(_ description: String) -> NSError{
        
        return NSError(domain: "com.scottishpowerTest.Error", code: -1, userInfo: [NSLocalizedDescriptionKey: description])
    }
}
