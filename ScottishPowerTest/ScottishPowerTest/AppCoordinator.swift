//
//  AppCoordinator.swift
//  ScottishPowerTest
//
//  Created by Stephen Biggerstaff on 01/03/2020.
//  Copyright © 2020 Stephen. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator: NSObject, Coordinator {
    
    var presenter: UINavigationController?
    var appWindow: UIWindow
    var coordinators: [String: Coordinator] = [:]
    
    init(window: UIWindow) {
        
        self.appWindow = window
    }

    func start() {
      
        guard let trackListVC = TrackListViewController.instantiate(storyboard: "Main", identifier: "TrackListViewController") else {
            debugPrint("Could not create view controller from storyboard and identifier given")
            return
        }
        
        let navigationController = UINavigationController(rootViewController: trackListVC)
        self.appWindow.rootViewController = navigationController
        self.presenter = navigationController
        self.appWindow.makeKeyAndVisible()
    }
}

extension AppCoordinator: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        
        // Check whether our view controller array already contains that view controller. If it does it means we’re pushing a different view controller on top rather than popping it, so exit.
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        
        // We’re still here – it means we’re popping the view controller, so we can check whether it’s a view controller
//        switch fromViewController {
//
//        case is ExampleViewController:
//            childDidFinish(exampleCoordinatorKey)
//        default:
//            debugLog("popped \(fromViewController) but we aren't coordinating that from here")
//        }
    }
}
