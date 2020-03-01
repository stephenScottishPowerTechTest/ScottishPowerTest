//
//  NetworkManager.swift
//  ScottishPowerTest
//
//  Created by Stephen on 01/03/2020.
//  Copyright © 2020 Stephen. All rights reserved.
//

import Foundation

typealias NetworkResponse =  (_ response: TracksResponse?, _ error: Error?) -> Void

/*
 In my personal projects I've taken to writing my own network stack rather than use third party libraries.
 This is my goto article on the subject and most of my own stuff is usually architected around this:
 https://medium.com/flawless-app-stories/writing-network-layer-in-swift-protocol-oriented-approach-4fa40ef1f908
 
 However in the interest of time, I'll simply use this network manager to do the single simple request that we need to perform.
 */

class NetworkManager {
    
    var session = URLSession.shared
    var task: URLSessionTask?
    
    /*
     Ideally a lot of the gritty details would be abstracted out to a router class and the request would be build up from an EndPoint enum.
     Also passing in the URL to the router allows the error handling here to be unit tested by passing different urls.
     
     I'd also abstract out the handling of the http response into smaller functions to be able to be unit tested.
     
     */
    func requestTrackList(completion: @escaping NetworkResponse) {
        
        task?.cancel()
        //given more time or in a work environment I would handle errors better with a custom type.
        guard let url = URL(string: "https://itunes.apple.com/search?term=rock&media=music") else {
            completion(nil, NSError(domain: "com.scottishpowerTest.NetworkError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unknown Error"]))
            return
        }
        
        task = session.dataTask(with: url) { data, response, error in
            
            if error != nil {
                
                completion(nil, error)
                return
                
            } else {
                
                if let httpResponse = response as? HTTPURLResponse, let data = data {
                    
                    if httpResponse.statusCode == 200 {
                        
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .iso8601
                        
                        do {
                            
                            let tracksResponse = try decoder.decode(TracksResponse.self, from: data)
                            
                            completion(tracksResponse, nil)
                            return
                            
                        } catch {
                            
                            completion(nil, NSError(domain: "com.scottishpowerTest.NetworkError",
                                                    code: -1,
                                                    userInfo: [NSLocalizedDescriptionKey: "Error decoding data)"]))
                            return
                        }
                        
                        
                        
                    } else {
                        
                        completion(nil, NSError(domain: "com.scottishpowerTest.NetworkError",
                                                code: -1,
                                                userInfo: [NSLocalizedDescriptionKey: "Status code \(httpResponse.statusCode)"]))
                        return
                    }
                    
                } else {
                    
                    completion(nil, NSError(domain: "com.scottishpowerTest.NetworkError",
                                            code: -1,
                                            userInfo: [NSLocalizedDescriptionKey: "Invalid HTTP response"]))
                    return
                }
            }
        }
        
        task?.resume()
        
    }
}
