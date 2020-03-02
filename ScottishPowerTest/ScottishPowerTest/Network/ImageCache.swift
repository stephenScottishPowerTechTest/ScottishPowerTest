//
//  ImageManager.swift
//  ScottishPowerTest
//
//  Created by Stephen on 01/03/2020.
//  Copyright © 2020 Stephen. All rights reserved.
//

import Foundation
import UIKit

class ImageManager {
    
    /*
     For quickness we will just store this in memory. This can most definitely be handled better, however NSCache is
     quite tolerant about memory warnings and getting rid of old data when it needs to. So in time provided I'll opt to use that
     rather than rolling my own cache and managing it smarter.
    */
    static var imageCache = NSCache<NSString, UIImage>()
    
    class func image(forURLString urlString: String) -> UIImage? {
        
        if let image = imageCache.object(forKey: urlString as NSString) {
            
            return image
        }
        
        return nil
    }
}
