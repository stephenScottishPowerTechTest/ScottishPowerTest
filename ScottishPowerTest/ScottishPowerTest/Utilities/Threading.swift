//
//  Threading.swift
//  ScottishPowerTest
//
//  Created by Stephen Biggerstaff on 01/03/2020.
//  Copyright © 2020 Stephen. All rights reserved.
//

import Foundation

extension DispatchQueue {
    
    class func ensureMainThread(_ code: @escaping () -> Void) {
    
        if Thread.isMainThread {
            
            code()
            return
        }
        
        DispatchQueue.main.sync(execute: code)
    }
}
