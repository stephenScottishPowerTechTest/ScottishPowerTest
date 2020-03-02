//
//  Coordinator.swift
//  ScottishPowerTest
//
//  Created by Stephen  on 01/03/2020.
//  Copyright © 2020 Stephen. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {

    func start()
}

protocol ResumableCoordinator: Coordinator {

    func resume()
}


protocol CoordinatedViewController: AnyObject {

    //Could further enhance this by defaulting to String(describing: class.self)
    static func instantiate(storyboard: String, identifier: String) -> Self?
}

extension CoordinatedViewController where Self: UIViewController {

    static func instantiate(storyboard: String, identifier: String) -> Self? {

        let bundle = Bundle(for: Self.self)
        let storyboard = UIStoryboard(name: storyboard, bundle: bundle)

        let viewController = storyboard.instantiateViewController(withIdentifier: identifier)

        return viewController as? Self
    }
}
