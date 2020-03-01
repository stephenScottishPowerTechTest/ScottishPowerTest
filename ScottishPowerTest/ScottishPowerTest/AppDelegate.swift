//
//  AppDelegate.swift
//  ScottishPowerTest
//
//  Created by Stephen on 01/03/2020.
//  Copyright © 2020 Stephen. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var appCoordinator: AppCoordinator?
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        let coordinator = AppCoordinator(window: window)
        self.appCoordinator = coordinator
        self.appCoordinator?.start()
        return true
    }
}

