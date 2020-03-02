//
//  NetworkManager.swift
//  ScottishPowerTest
//
//  Created by Stephen on 01/03/2020.
//  Copyright © 2020 Stephen. All rights reserved.
//

import Foundation

typealias NetworkResponseHandler =  (_ response: TracksResponse?, _ error: Error?) -> Void

/*
 In my personal projects I've taken to writing my own network stack rather than use third party libraries.
 This is my goto article on the subject and most of my own stuff is usually architected around this:
 https://medium.com/flawless-app-stories/writing-network-layer-in-swift-protocol-oriented-approach-4fa40ef1f908
 */

enum NetworkResponse:String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum Result<String>{
    case success
    case failure(String)
}

class NetworkManager {
    
    private let router = Router()
    
    /*
     Ideally a lot of the gritty details would be abstracted out to a router class and the request would be build up from an EndPoint enum.
     Also passing in the URL to the router allows the error handling here to be unit tested by passing different urls.
     
     I'd also abstract out the handling of the http response into smaller functions to be able to be unit tested.
     
     */
    func requestTrackList(completion: @escaping NetworkResponseHandler) {
       
        guard let url = URL(string: "https://itunes.apple.com/search?term=rock&media=music") else {
            
            completion(nil, NSError.error("Unable to parse URL for track list"))
            return
        }
        
        router.absoluteRequest(url: url) { (data, response, error) in
            
            if error != nil {
                
                completion(nil, NSError.error("Please check your network connection."))
            }
            
            if let response = response as? HTTPURLResponse {
                
                let result = self.handleNetworkResponse(response)
                
                switch result {
                    
                case .success:
                    
                    guard let responseData = data else {
                        
                        completion(nil, NSError.error(NetworkResponse.noData.rawValue))
                        return
                    }
                    
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    
                    do {
                        
                        let tracksResponse = try decoder.decode(TracksResponse.self, from: responseData)
                        completion(tracksResponse, nil)
                        return
                        
                    } catch {
                        
                        completion(nil, NSError(domain: "com.scottishpowerTest.NetworkError",
                                                code: -1,
                                                userInfo: [NSLocalizedDescriptionKey: "Error decoding data)"]))
                        return
                    }
                    
                    
                case .failure(let networkFailureError):
                    
                    completion(nil, NSError.error(networkFailureError))
                }
            }
        }
    }
    
    private func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        
        switch response.statusCode {
            
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
            
        }
    }
}


