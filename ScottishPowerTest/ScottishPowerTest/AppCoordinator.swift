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
    
    let tracksFlowCoordinatorKey = "TracksListCoordinator"
    
    var presenter: UINavigationController?
    var appWindow: UIWindow
    var coordinators: [String: Coordinator] = [:]
    
    init(window: UIWindow) {
        
        self.appWindow = window
    }

    func start() {
      
        let navigationController = UINavigationController()
        self.appWindow.rootViewController = navigationController
        self.presenter = navigationController
        self.appWindow.makeKeyAndVisible()
        self.presentApplication()
    }
    
    private func presentApplication() {
        //Typically this function could decide to show a login or proceed to the application
        //This would require a think around which view should be root, or maybe a blank root vc
        self.presentTracksFlow()
    }
    
    private func presentTracksFlow() {
        
        let trackFlowCoordinator = TracksFlowCoordinator(presenter: self.presenter)
        trackFlowCoordinator.start()
        self.coordinators[tracksFlowCoordinatorKey] = trackFlowCoordinator
    }
}

extension AppCoordinator: UINavigationControllerDelegate {
    
    //Memory managing the coordinators based on when they have their root view popped off the stack.
    //Adapted from: https://www.hackingwithswift.com/articles/175/advanced-coordinator-pattern-tutorial-ios
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
