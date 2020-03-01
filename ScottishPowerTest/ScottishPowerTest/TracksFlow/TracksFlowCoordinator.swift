//
//  TracksFlowCoordinator.swift
//  ScottishPowerTest
//
//  Created by Stephen Biggerstaff on 01/03/2020.
//  Copyright © 2020 Stephen. All rights reserved.
//

import Foundation
import UIKit

protocol TracksFlowCoordination {
    
    func detailsRequested(from viewController: UIViewController) //TODO: Add track that we're navigating to.
}

class TracksFlowCoordinator: Coordinator {
    
    weak var presenter: UINavigationController?
    
    init(presenter: UINavigationController?) {
        
        self.presenter = presenter
    }
    
    func start() {
        
        guard let trackListVC = TrackListViewController.instantiate(storyboard: "TracksFlow", identifier: "TrackListViewController") else {
            debugPrint("Could not create view controller from storyboard and identifier given")
            return
        }
        
        self.presenter?.pushViewController(trackListVC, animated: false)
    }
}

extension TracksFlowCoordinator: TracksFlowCoordination {
    
    func detailsRequested(from viewController: UIViewController) {
        
        //TODO: Move to track details
    }
}
