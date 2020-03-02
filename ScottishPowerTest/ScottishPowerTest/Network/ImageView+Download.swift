//
//  ImageView+Download.swift
//  ScottishPowerTest
//
//  Created by Stephen Biggerstaff on 01/03/2020.
//  Copyright © 2020 Stephen. All rights reserved.
//

import Foundation
import UIKit

/*  I wouldn't normally do this in UIImageView. I'd say it's the network managers job to download and sort the
    caching of images. However this is a first attempt at making sure the image downloads work and the technique is solid.
 */
extension UIImageView {
    
    func loadImage(fromURLString urlString: String) {
        
        guard let url = URL(string: urlString) else {
            debugPrint("Error creating url for image download")
            return
            
        }
            
        self.image = nil
        
        if let image = ImageManager.image(forURLString: urlString) {
            
            DispatchQueue.ensureMainThread {
                
                self.image = image
            }
            
        } else {
            
            let session = URLSession.shared
            
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if error != nil {
                    
                    debugPrint(error?.localizedDescription ?? "Unknown error")
                }
                
                if let data = data, let downloadedImage = UIImage(data: data) {
                    
                    DispatchQueue.ensureMainThread {
                        
                        ImageManager.imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                        self.image = downloadedImage
                    }
                    
                } else {
                    
                    debugPrint("No data for Image request: \(urlString)")
                }
            }
            
            task.resume()
        }
        
        
    }
}
