//
//  Router.swift
//  ScottishPowerTest
//
//  Created by Stephen Biggerstaff on 01/03/2020.
//  Copyright © 2020 Stephen. All rights reserved.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

protocol NetworkRouter: class {
    
    func absoluteRequest(url: URL, completion: @escaping NetworkRouterCompletion)
    func cancel()
}

class Router: NetworkRouter {
    
    private var task: URLSessionTask?
    
    func absoluteRequest(url: URL, completion: @escaping NetworkRouterCompletion) {
        
        let session = URLSession.shared
        
        task = session.dataTask(with: url, completionHandler: { data, response, error in
            completion(data, response, error)
        })
        
        self.task?.resume()
    }
    
    func cancel() {
        
        self.task?.cancel()
    }
}
